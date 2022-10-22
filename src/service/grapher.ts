import { HeadAndShoulders } from "../draw-tool/head_and_shoulders";
import { Canvas } from "../grapher/canvas";
import { Grapher } from "../grapher/grapher";
import { Interaction, InteractionEvent, InteractionType } from "../grapher/interaction";
import { Layer } from "../grapher/layer";
import { Window } from "./window";

export enum GrapherMode {
    view,
    head_and_shoulders
}

export class GrapherService {
    static obj: Grapher
    private static store: Map<String, Layer> = new Map()
    private static draw_layer?: HeadAndShoulders
    private static mode = GrapherMode.view

    static init(): void {
        const canvas = new Canvas()
        this.obj = new Grapher(canvas)
        this.mode = GrapherMode.view
        this.obj.interaction.register_on_event(InteractionType.scroll, (i, ev) => this.on_scroll(i, ev))
        this.obj.interaction.register_on_event(InteractionType.touch_move, (i, ev) => this.on_touch_move(i, ev))
        // this.obj.interaction.register_on_event(InteractionType.touch_down, (i, ev) => this.last_x_pos = ev.x)
    }

    static add(id: string, layer: Layer) {
        this.store.set(id, layer)
    }

    static set_mode(mode: GrapherMode) {
        this.mode = mode
        if(mode == GrapherMode.head_and_shoulders) {
            this.draw_layer = new HeadAndShoulders()
        
        //     const draw_tool = new HeadAndShoulders(this.on_draw_tool_data_changed)
        //     this.draw_layer = new InteractiveLayer(empty_val_list, draw_tool, false)
        //     const store_id = `draw_head_and_shoulder_${Misc.generate_unique_id}`
        //     this.add(store_id, this.draw_layer)
        }
    }


    private static on_scroll(i: Interaction, ev: InteractionEvent) {
        const delta_yscroll = ev.delta_y!
        const delta_cell_width = delta_yscroll / Window.cell_width
        Window.zoom(delta_cell_width)
        this.rebuild()
    }


    private static on_touch_move(i: Interaction, ev: InteractionEvent) {
        if(!ev.is_touch_down) return
        Window.shift(ev.delta_x! / Window.cell_width)
        this.rebuild()
    }
    
    private static build_windowed_layers(): Layer[] {
        const layers: Layer[] = []
        for(const [id, layer] of this.store) {
            const cut_layer = Window.make_cut_layer(layer)
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
    
    static get_price_based_template() {
        const price = this.store.get('price')
        const empty_val_list = Layer.extract_timestamp(price!)
        return empty_val_list
    }
}