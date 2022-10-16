import { Canvas } from "./grapher/canvas"
import { InputJSONArray } from "./grapher/grapher"
import { Layer } from "./grapher/layer"
import { GrapherService } from "./service/grapher"

export class Window {
    static readonly DEFAULT_CELL_WIDTH = 8
    cell_width: number
    canvas: Canvas
    private start_index = 0
    original_data_length = 0

    constructor(canvas: Canvas, cell_width = Window.DEFAULT_CELL_WIDTH) {
        this.cell_width = cell_width
        this.canvas = canvas
    }

    make_cut_layer(layer: Layer): Layer {
        this.original_data_length = layer.data.length
        const window = this.cut_data(layer.data)
        const layer_cut = Layer.copy_and_set_data(layer, window)
        return layer_cut
    }

    private cut_data(original_data: InputJSONArray) {
        const window = original_data.slice(this.start_index, this.end_index)
        return window
    }

    shift(value: number) {
        const new_start_index = this.start_index + value
        if(new_start_index < 0) return
        if(new_start_index + this.length > this.original_data_length) return
        this.start_index += value
    }

    get length(): number { return ~~(this.canvas.source.width / this.cell_width) }
    get end_index(): number { return this.start_index + this.length }

}