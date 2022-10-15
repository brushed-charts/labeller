import { Canvas } from "./canvas"
import { Interaction } from "./interaction"
import { Layer } from "./layer"
import { Range } from "./utils/range"
import { VirtualAxis } from "./virtual-axis"

export type InputJSONArray = Array<Map<String, any>>

export class Grapher {
    static readonly CELL_WIDTH = 20
    static readonly CELL_MARGIN_PERCENT = 0.2
    canvas: Canvas
    layers: Array<Layer>
    y_axis: VirtualAxis
    cell_width = Grapher.CELL_WIDTH
    scroll_callbacks: Array<Function> = []
    interaction: Interaction
    

    constructor(canvas: Canvas) {
        this.canvas = canvas
        this.layers = []
        this.y_axis = new VirtualAxis(new Range(0, canvas.source.height))
        this.interaction = new Interaction(this.canvas)
    }
    
    add(layer: Layer): void {
        layer.grapher = this
        let virtual_range = this.y_axis.virtual_range
        virtual_range = Range.extremum(virtual_range, layer.range)
        this.y_axis.virtual_range = virtual_range
        this.layers.push(layer)
        // this.cell_width = this.canvas.source.width / this.get_max_data_length()
    }

    get_max_data_length(): number {
        const max_layer = this.layers.reduce((p, c) => (p.data.length > c.data.length)? p: c)
        return max_layer.data.length
    }

    update(): void {
        this.layers.forEach(layer => {
            layer.tool.draw(layer, this.canvas)
        });        
    }

    handle_scroll_event() {
        
    }

    
    subscribe_to_scroll(scroll_callback: Function): void {
        this.scroll_callbacks.push(scroll_callback)
    }


}