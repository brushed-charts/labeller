import { Canvas } from "./grapher/canvas"
import { Layer } from "./grapher/layer"

export class Window {
    static readonly DEFAULT_LENGTH= 100
    canvas: Canvas
    start_index = 0
    end_index = 0
    original_data_length = 0

    constructor(canvas: Canvas, length = Window.DEFAULT_LENGTH) {
        this.canvas = canvas
        this.end_index = length
    }

    make_cut_layer(layer: Layer): Layer {
        this.original_data_length = layer.data.length
        const window = layer.data.slice(this.start_index, this.end_index)
        const layer_cut = Layer.copy_and_set_data(layer, window)
        return layer_cut
    }

    zoom(value: number) {
        const end_index = this.end_index - value
        if(end_index > this.original_data_length) return
        this.end_index -= value
    }

    shift(value: number) {
        const start_index = this.start_index + value
        const end_index = this.end_index + value
        if(start_index < 0 || end_index > this.original_data_length) 
            return
        this.start_index += value
        this.end_index += value
    }

    get length(): number { return ~~(this.end_index - this.start_index) }
    get cell_width(): number { return this.canvas.source.width / this.length}

}