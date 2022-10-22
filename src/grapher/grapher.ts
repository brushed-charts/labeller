import { Canvas } from "./canvas"
import { CrossCursor } from "./cross-cursor"
import { Interaction } from "./interaction"
import { Layer } from "./layer"
import { Range } from "./utils/range"
import { VirtualAxis } from "./virtual-axis"

export type InputJSONArray = Array<Map<String, any>>

export class Grapher {
    static readonly CELL_MARGIN_PERCENT = 0.2
    private layers: Array<Layer>
    canvas: Canvas
    y_axis: VirtualAxis
    interaction: Interaction
    cross_cursor: CrossCursor

    get cell_width(): number {return this.canvas.source.width / this.get_cell_count()}
    

    constructor(canvas: Canvas) {
        this.canvas = canvas
        this.interaction = new Interaction(this)
        this.cross_cursor = new CrossCursor(this)
        this.clear()
    }

    clear(): void {
        this.layers = []
        this.y_axis = new VirtualAxis(new Range(0, this.canvas.source.height))
    }
    
    add(layer: Layer): void {
        layer.grapher = this
        this.layers.push(layer)
        if(layer.affect_shared_yaxis)
            this.update_yaxis(layer)
    }

    private update_yaxis(layer: Layer) {
        let virtual_range = this.y_axis.virtual_range
        virtual_range = Range.extremum(virtual_range, layer.range!)
        this.y_axis.virtual_range = virtual_range
        
    }

    private get_cell_count(): number {
        const max_layer = this.layers.reduce((p, c) => (p.data.length > c.data.length)? p: c)
        return max_layer.data.length
    }

    update(): void {
        this.canvas.clear()
        this.cross_cursor.draw()
        for(const layer of this.layers) {
            layer.tool.draw(layer, this.canvas)
        }
    }
}