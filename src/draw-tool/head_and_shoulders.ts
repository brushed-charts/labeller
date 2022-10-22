import { AnchorLine } from "../grapher/draw-tool/anchor-line";
import { InteractionEvent, InteractionType, Subscriber } from "../grapher/interaction";
import { Layer } from "../grapher/layer";
import Misc from "../misc";
import { GrapherService } from "../service/grapher";
import { Window } from "../service/window";

export class HeadAndShoulders {
    static readonly PATTERN_POINT = 7
    static readonly ID_PREFIX = 'head_and_shoulders'
    private interaction_id: string
    private layer_id: string
    private current_layer: Layer
    private get point_count(): number { 
        let count = 0
        for(const val of this.current_layer.data) {
            if(!val['value']) continue
            count++
        }
        return count
    }

    constructor() {
        this.interaction_id = `head_and_shoulder_${Misc.generate_unique_id()}`
        const interaction_subscriber = new Subscriber(this.interaction_id, (_, ev) => this.on_tap(ev))
        GrapherService.obj.interaction.register_on_event(InteractionType.tap, interaction_subscriber)
        // GrapherService.obj.interaction.register_on_event(InteractionType.tap, interaction_subscriber)
        this.reset()
    }

    private reset() {
        this.refresh_layer_id()
        const data_template = GrapherService.get_price_based_template()
        this.current_layer = new Layer(data_template, new AnchorLine(), false)
    }

    on_tap(ev: InteractionEvent) {
        this.construct_pattern(ev)
        this.reset_on_completed_pattern()
    }
    

    private reset_on_completed_pattern() {
        if (this.point_count < HeadAndShoulders.PATTERN_POINT) return
        this.reset()
    }

    private construct_pattern(ev: InteractionEvent) {
        if (this.point_count > HeadAndShoulders.PATTERN_POINT) return
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

    private refresh_layer_id(): void {
        const unique_id = Misc.generate_unique_id()
        this.layer_id = HeadAndShoulders.ID_PREFIX + `.${unique_id}`
    }

    detach() {
        GrapherService.obj.interaction.remove_subscription(InteractionType.touch_down, this.interaction_id)
    }
}