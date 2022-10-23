import { Canvas } from "../grapher/canvas";
import { Grapher } from "../grapher/grapher";
import { Interaction, InteractionEvent, InteractionType, Subscriber } from "../grapher/interaction";
import { GraphWindow } from "./window";
import { GraphDrawer } from "./drawer";
import { DrawTool } from "../draw-tool/draw-tool";
import { HeadAndShoulders } from "../draw-tool/head_and_shoulders";

export enum GrapherMode {
    view,
    head_and_shoulders
}

export enum LayerType {
    static = 'static',
    head_and_shoulders = 'head_and_shoulders'
}

export class GrapherService {
    private static readonly interaction_id = 'grapher_service'
    static obj: Grapher
    private static mode = GrapherMode.view
    private static draw_tool?: DrawTool

    static init(): void {
        const canvas = new Canvas()
        this.obj = new Grapher(canvas)
        this.mode = GrapherMode.view
        this.obj.interaction.register_on_event(InteractionType.scroll, new Subscriber(this.interaction_id, (i, ev) => this.on_scroll(i, ev)))
        this.obj.interaction.register_on_event(InteractionType.touch_move, new Subscriber(this.interaction_id, (i, ev) => this.on_touch_move(i, ev)))
    }

    static set_mode(mode: GrapherMode) {
        this.draw_tool?.detach()
        this.mode = mode
        if(mode == GrapherMode.head_and_shoulders) {
            this.draw_tool = new HeadAndShoulders()
        }
    }

    private static on_scroll(i: Interaction, ev: InteractionEvent) {
        const delta_yscroll = ev.delta_y!
        const delta_cell_width = delta_yscroll / GraphWindow.cell_width
        GraphWindow.zoom(delta_cell_width)
        GraphDrawer.refresh()
    }


    private static on_touch_move(i: Interaction, ev: InteractionEvent) {
        GraphWindow.shift(ev.delta_x! / GraphWindow.cell_width)
        GraphDrawer.refresh()
    }


}