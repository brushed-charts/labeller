import { InputJSONArray } from "./grapher/grapher"
import { Layer } from "./grapher/layer"

export class Window {
    static readonly DEFAULT_LENGTH = 70
    length = Window.DEFAULT_LENGTH
    start_index = 0
    get end_index(): number {return this.start_index + this.length}

    constructor(length = Window.DEFAULT_LENGTH) {
        this.length = length
    }

    make_cut_layer(layer: Layer): Layer {
        const window = this.cut_data(layer.data)
        const layer_cut = Layer.copy_and_set_data(layer, window)
        return layer_cut
    }

    private cut_data(original_data: InputJSONArray) {
        let window = original_data.reverse()
        window = window.slice(this.start_index, this.end_index)
        window = window.reverse()
        
        return window
    }
}