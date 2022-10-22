import { Line } from "../grapher/draw-tool/line";
import { InteractionEvent, InteractionType } from "../grapher/interaction";
import { Layer } from "../grapher/layer";
import Misc from "../misc";
import { GrapherService } from "../service/grapher";
import { Window } from "../service/window";

export class HeadAndShoulders{
    static readonly ID_PREFIX = 'head_and_shoulders'
    private layer_id: string
    private current_layer: Layer

    constructor() {
        GrapherService.obj.interaction.register_on_event(InteractionType.touch_down, (_, ev) => this.on_touch_down(ev))
        const data_template = GrapherService.get_price_based_template()
        this.current_layer = new Layer(data_template, new Line(), false)
        this.layer_id = HeadAndShoulders.ID_PREFIX + `.${Misc.generate_unique_id()}`
        
    }
    
    on_touch_down(ev: InteractionEvent) {
        const index_to_edit = this.deduce_data_index_from_x_position(ev.x)
        const price = this.convert_y_pos_to_price(ev.y)
        this.set_price_at_data_index(index_to_edit, price)
        GrapherService.add(this.layer_id, this.current_layer)
        
    }

    private set_price_at_data_index(index: number, price: number) {
        const data_array = this.current_layer.data
        const object_to_edit = data_array[index]
        object_to_edit['value'] = price
    }

    private convert_y_pos_to_price(y_pos: number) {
        const price = GrapherService.obj.y_axis.toVirtual(y_pos)
        return price
    }

    private deduce_data_index_from_x_position(x_pos: number) {
        const windowed_index = this.get_inner_window_index_from_click_pos(x_pos)
        const global_index = Window.convert_to_global_index(windowed_index)
        return global_index
    }

    private get_inner_window_index_from_click_pos(x_pos: number) {
        const cell_count_at_click = Math.ceil(x_pos / Window.cell_width)
        const cell_count_from_right = Window.cell_count - cell_count_at_click
        const local_index = cell_count_from_right
        return local_index
    }
}