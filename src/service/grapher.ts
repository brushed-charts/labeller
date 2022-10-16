import { Canvas } from "../grapher/canvas";
import { Grapher, InputJSONArray } from "../grapher/grapher";
import { Interaction, InteractionEvent, InteractionEventCallback, InteractionType } from "../grapher/interaction";
import { Layer } from "../grapher/layer";
import { Window } from "../window";

export class GrapherService {
    static obj: Grapher
    private static store: Map<String, Layer> = new Map()
    private static window: Window

    static init(): void {
        const canvas = new Canvas()
        this.obj = new Grapher(canvas)
        this.window = new Window(canvas)
        this.obj.interaction.register_on_event(InteractionType.scroll, (i, ev) => this.on_scroll(i, ev))
        this.obj.interaction.register_on_event(InteractionType.touch_move, (i, ev) => this.on_touch_move(i, ev))
        // this.obj.interaction.register_on_event(InteractionType.touch_down, (i, ev) => this.last_x_pos = ev.x)
    }

    static add(id: string, layer: Layer) {
        this.store.set(id, layer)
    }

    private static on_scroll(i: Interaction, ev: InteractionEvent) {
        const delta_yscroll = ev.y
        const old_window_length = this.window.length
        const delta_cell_width = delta_yscroll / this.window.length
        this.window.cell_width += delta_cell_width
        if(old_window_length == this.window.length) return
        this.rebuild()
    }


    private static on_touch_move(i: Interaction, ev: InteractionEvent) {
        if(!ev.is_touch_down) return
        this.window.shift(ev.x / this.window.cell_width)
        this.rebuild()
    }
    
    private static build_windowed_layers(): Layer[] {
        const layers: Layer[] = []
        for(const [id, layer] of this.store) {
            const cut_layer = this.window.make_cut_layer(layer)
            layers.push(cut_layer)
        }
        return layers
    }

    static rebuild(): void {
        const layers = this.build_windowed_layers()
        this.obj.clear()
        for(const layer of layers) {
            this.obj.add(layer)
        }
        this.draw()
    }

    static draw(): void{
        this.obj.update()
    }    
}