import { Canvas } from "../canvas";
import { Grapher, InputJSONArray } from "../grapher";
import { Layer } from "../layer";
import { Range } from "../utils/range";
import { VirtualAxis } from "../virtual-axis";
import { DrawTool } from "./base";

export class Line implements DrawTool {
    layer: Layer
    cursor_x: number
    width: number
    color: string
    previous_y_value?: number
    previous_cursor_x?: number

    get y_axis(): VirtualAxis { return this.layer.grapher.y_axis }

    constructor(color: string = 'yellow', width = 1) {
        this.color = color
        this.width = width
    }

    reset() {
        this.previous_cursor_x = undefined
        this.previous_cursor_x = undefined
    }

    draw(layer: Layer) {
        this.reset()
        this.layer = layer
        this.cursor_x = layer.grapher.canvas.source.width
        for (const json_data of layer.data) {
            const y_price = json_data['value']
            this.draw_line(y_price)
            this.cursor_x -= this.layer.grapher.cell_width
        }
    }

    private draw_line(y_value: number) {
        const margin = this.layer.grapher.cell_width / 2
        const ctx = this.layer.grapher.canvas.context
        const x = this.cursor_x - margin
        const y = this.y_axis.toPixel(y_value)
        
        if(this.previous_cursor_x != undefined && this.previous_y_value != undefined) {
            ctx.strokeStyle = this.color
            ctx.lineWidth = this.width
            ctx.beginPath();
            ctx.moveTo(this.previous_cursor_x, this.previous_y_value)
            ctx.lineTo(x, y)
            ctx.stroke()
        }
        this.previous_cursor_x = x
        this.previous_y_value = y
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