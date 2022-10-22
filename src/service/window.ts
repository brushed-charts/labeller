import { Canvas } from "../grapher/canvas"
import { Layer } from "../grapher/layer"
import { GrapherService } from "./grapher"

export class Window {
    static readonly DEFAULT_LENGTH= 100
    private static start_index = 0
    private static end_index = this.DEFAULT_LENGTH
    private static original_data_length = 0


    static make_cut_layer(layer: Layer): Layer {
        this.original_data_length = layer.data.length
        const window = layer.data.slice(this.start_index, this.end_index)
        const layer_cut = Layer.copy_and_set_data(layer, window)
        return layer_cut
    }

    static zoom(value: number) {
        const end_index = this.end_index - value
        if(end_index > this.original_data_length) return
        this.end_index -= value
    }

    static shift(value: number) {
        const start_index = this.start_index + value
        const end_index = this.end_index + value
        if(start_index < 0 || end_index > this.original_data_length) 
            return
        this.start_index += value
        this.end_index += value
    }

    static convert_to_global_index(local_index: number) {
        return Math.floor(this.start_index + local_index)
    }

    static get cell_count(): number { return ~~(this.end_index - this.start_index) }
    static get cell_width(): number { return GrapherService.obj.canvas.source.width / this.cell_count}

}