import { Canvas } from "../canvas";
import { Grapher, InputJSONArray } from "../grapher";
import { Layer } from "../layer";
import { Range } from "../utils/range";
import { VirtualAxis } from "../virtual-axis";
import { DrawTool } from "./base";

export class Volume implements DrawTool {
    layer: Layer
    cursor_x: number
    bar_width_percent: number
    height_percent: number
    color: string
    y_axis: VirtualAxis
    

    constructor(color: string = '#FF7F0030', bar_width_percent = 0.05, height_percent = 0.1) {
        this.color = color
        this.bar_width_percent = bar_width_percent
        this.height_percent = height_percent
    }

    configure_virutal_range(): void {
        const canvas_height = this.layer.grapher.canvas.source.height
        const up_range = canvas_height - canvas_height * this.height_percent
        this.y_axis = new VirtualAxis(new Range(up_range, canvas_height))
        this.y_axis.virtual_range = this.layer.range
    }

    draw(layer: Layer) {
        this.layer = layer
        this.cursor_x = layer.grapher.canvas.source.width
        this.configure_virutal_range()
        for (const json_data of layer.data) {
            const y_price = json_data['value']
            this.draw_bar(y_price)
            this.cursor_x -= this.layer.grapher.cell_width
        }
    }

    private draw_bar(price: number) {
        const margin = Grapher.CELL_MARGIN_PERCENT * this.layer.grapher.cell_width
        const ctx = this.layer.grapher.canvas.context
        const x = this.cursor_x - margin
        const y_bottom = this.layer.grapher.canvas.source.height
        const y_up = this.y_axis.toPixel(price)
        const width = -(this.layer.grapher.cell_width - margin*2)
        const height = y_bottom - y_up
        
        console.log(y_bottom, y_up, x, width, height);
        
        ctx.fillStyle = this.color
        ctx.fillRect(x, y_up, width, height)
    }


    getRange(input: InputJSONArray): Range {
        let min = Number.MAX_SAFE_INTEGER
        let max = Number.MIN_SAFE_INTEGER
        for (const json_data of input) {
            const yvalue = json_data['value']
            min = Math.min(yvalue, min)
            max = Math.max(yvalue, max)
        }
        return new Range(min, max)
    }


}