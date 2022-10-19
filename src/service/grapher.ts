import { Canvas } from "../grapher/canvas";
import { DrawTool } from "../grapher/draw-tool/base";
import { Grapher } from "../grapher/grapher";
import { Interaction, InteractionEvent, InteractionType } from "../grapher/interaction";
import { Layer } from "../grapher/layer";
import { Window } from "../window";

export class GrapherService {
    static obj: Grapher
    private static store: Map<String, Layer> = new Map()
    private static window: Window
    private static draw_tool?: DrawTool

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
        const delta_yscroll = ev.delta_y!
        const delta_cell_width = delta_yscroll / this.window.cell_width
        this.window.zoom(delta_cell_width)
        this.rebuild()
    }


    private static on_touch_move(i: Interaction, ev: InteractionEvent) {
        if(!ev.is_touch_down) return
        this.window.shift(ev.delta_x! / this.window.cell_width)
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