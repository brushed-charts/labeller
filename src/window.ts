import { Canvas } from "./grapher/canvas"
import { InputJSONArray } from "./grapher/grapher"
import { Layer } from "./grapher/layer"

export class Window {
    static readonly DEFAULT_CELL_WIDTH = 10
    cell_width: number
    canvas: Canvas
    start_index = 0

    constructor(canvas: Canvas, cell_width = Window.DEFAULT_CELL_WIDTH) {
        this.cell_width = cell_width
        this.canvas = canvas
    }

    make_cut_layer(layer: Layer): Layer {
        const window = this.cut_data(layer.data)
        const layer_cut = Layer.copy_and_set_data(layer, window)
        return layer_cut
    }

    private cut_data(original_data: InputJSONArray) {
        original_data.reverse()
        const window = original_data.slice(this.start_index, this.end_index)
        original_data.reverse()
        return window
    }


    get length(): number {return ~~(this.canvas.source.width / this.cell_width)}
    get end_index(): number {return this.start_index + this.length}
    
}