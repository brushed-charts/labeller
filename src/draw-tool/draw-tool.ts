import { InputJSONArray } from "../grapher/grapher"
import { InteractionEvent, InteractionType, Subscriber } from "../grapher/interaction"
import { Layer } from "../grapher/layer"
import Misc from "../misc"
import { GrapherService, LayerType } from "../service/grapher"
import { GraphStorage } from "../service/storage"
import { GraphWindow } from "../service/window"
import { Point } from "../grapher/utils/point"

export abstract class DrawTool {
    protected PATTERN_POINT: number
    protected ID_PREFIX: string
    protected interaction_id: string
    protected layer_id: string
    protected current_layer: Layer
    protected layer_type: LayerType
    protected get point_count(): number {
        let count = 0
        for (const val of this.current_layer.data) {
            if (!val['value']) continue
            count++
        }
        return count
    }

    protected attach() {
        const interaction_tap_subscriber = new Subscriber(this.interaction_id, (_, ev) => this.on_tap(ev))
        // const interaction_move_subscriber = new Subscriber(this.interaction_id, (_, ev) => this.on_touch_move(ev))
        GrapherService.obj.interaction.register_on_event(InteractionType.tap, interaction_tap_subscriber)
        // GrapherService.obj.interaction.register_on_event(InteractionType.touch_move, interaction_move_subscriber)
    }

    public detach() {
        GrapherService.obj.interaction.remove_subscription(InteractionType.tap, this.interaction_id)
    }

    // protected on_touch_move(ev: InteractionEvent): void {
    //     const coord = new Point(ev.x, ev.y)
    //     const is_touched = this.is_touched(coord)
        
    // }

    // public is_touched(coord: Point): boolean {
    //     if(this.get_touched_anchor(coord)) {
    //         return true
    //     }
    //     return false
    // }

    // public get_touched_anchor(coord: Point): Map<String, any> | undefined {
    //     const layers = GraphStorage.get_layers_by_type(this.layer_type)
        
    //     let anchor: Map<string, any> | undefined
    //     for (const layer of layers) {
    //         anchor = this.get_anchor_at_timestamp(layer, coord)
    //         if(!this.is_anchor_is_touched(anchor!, coord.y)) {
    //             anchor = undefined
    //             continue
    //         }
    //         break
    //     }
    //     return anchor
    // }

    // private get_anchor_at_timestamp(layer: Layer, coord: Point): any {
    //     const index = this.deduce_data_index_from_x_position(coord.x)
    //     const cell_data = layer.data[index]
    //     return cell_data
    // }

    // private is_anchor_is_touched(data: Map<String, any>, y_touch_pos: number) {
    //     const price = data['value']
    //     const y_pixel = GrapherService.obj.y_axis.toPixel(price)
    //     console.log(data, y_pixel, price);
        
    //     if(y_touch_pos == y_pixel) {
    //         return true
    //     }
    //     return false
    // }


    protected on_tap(ev: InteractionEvent) {
        this.construct_pattern(ev)
        this.reset_on_completed_pattern()
    }

    protected reset_on_completed_pattern() {
        if (this.point_count < this.PATTERN_POINT) return
        this.reset()
    }

    protected construct_pattern(ev: InteractionEvent) {
        if (this.point_count > this.PATTERN_POINT) return
        const index_to_edit = this.deduce_data_index_from_x_position(ev.x)
        const price = this.convert_y_pos_to_price(ev.y)
        this.set_price_at_data_index(index_to_edit, price)
        GraphStorage.upsert(this.layer_id, this.current_layer)
    }

    protected set_price_at_data_index(index: number, price: number) {
        const data_array = this.current_layer.data
        const object_to_edit = data_array[index]
        object_to_edit['value'] = price
    }

    protected convert_y_pos_to_price(y_pos: number) {
        const price = GrapherService.obj.y_axis.toVirtual(y_pos)
        return price
    }

    protected deduce_data_index_from_x_position(x_pos: number) {
        const windowed_index = this.get_inner_window_index_from_click_pos(x_pos)
        const global_index = GraphWindow.convert_to_global_index(windowed_index)
        return global_index
    }

    protected get_inner_window_index_from_click_pos(x_pos: number) {
        const cell_count_at_click = Math.ceil(x_pos / GraphWindow.cell_width)
        const cell_count_from_right = GraphWindow.cell_count - cell_count_at_click
        const local_index = cell_count_from_right
        return local_index
    }

    protected refresh_layer_id(): void {
        const unique_id = Misc.generate_unique_id()
        this.layer_id = this.ID_PREFIX + `.${unique_id}`
    }

    protected reset() {
        this.refresh_layer_id()
        const data_template = GraphStorage.get_price_based_template()
        this.current_layer = this.define_layer(data_template)
        
    }

    protected abstract define_layer(data_template: InputJSONArray): Layer


}