import { Canvas } from "./canvas"
import { Interaction } from "./interaction"
import { Layer } from "./layer"
import { Range } from "./utils/range"
import { VirtualAxis } from "./virtual-axis"

export type InputJSONArray = Array<Map<String, any>>

export class Grapher {
    static readonly CELL_MARGIN_PERCENT = 0.2
    canvas: Canvas
    layers: Array<Layer>
    y_axis: VirtualAxis
    cell_width: number
    interaction: Interaction
    

    constructor(canvas: Canvas) {
        this.canvas = canvas
        this.interaction = new Interaction(this)
        this.clear()
    }

    clear(): void {
        this.layers = []
        this.y_axis = new VirtualAxis(new Range(0, this.canvas.source.height))
    }
    
    add(layer: Layer): void {
        layer.grapher = this
        let virtual_range = this.y_axis.virtual_range
        virtual_range = Range.extremum(virtual_range, layer.range)
        this.y_axis.virtual_range = virtual_range
        this.layers.push(layer)
        this.cell_width = this.canvas.source.width / this.get_max_data_length()
    }

    get_max_data_length(): number {
        const max_layer = this.layers.reduce((p, c) => (p.data.length > c.data.length)? p: c)
        return max_layer.data.length
    }

    update(): void {
        this.canvas.clear()
        for(const layer of this.layers) {
            layer.tool.draw(layer, this.canvas)
        }
    }
}