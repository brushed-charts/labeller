import { Canvas } from "./canvas"
import { Layer } from "./layer"
import { Range } from "./utils/range"
import { VirtualAxis } from "./virtual-axis"

export type InputJSONArray = Array<Map<String, any>>

export class Grapher {
    canvas: Canvas
    layers: Array<Layer>
    interval: number
    y_axis: VirtualAxis
    data_count = 0
    unit_interval = 0

    constructor(canvas: Canvas) {
        this.canvas = canvas
        this.layers = []
        this.y_axis = new VirtualAxis(new Range(0, canvas.source.height))
        this.unit_interval = 0
    }
    
    add(layer: Layer): void {
        layer.grapher = this
        let virtual_range = this.y_axis.virtual_range
        virtual_range = Range.extremum(virtual_range, layer.range)
        this.y_axis.virtual_range = virtual_range
        this.layers.push(layer)
        this.data_count = Math.max(this.unit_interval, layer.data.length)
        this.unit_interval = this.canvas.source.width / this.data_count
    }

    update(): void {
        this.layers.forEach(layer => {
            layer.tool.draw(layer, this.canvas)
        });        
    }


}