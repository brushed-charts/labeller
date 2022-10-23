import { Grapher } from "./grapher";

export class InteractionEvent {
    x: number
    y: number
    delta_x?: number
    delta_y?: number
    is_touch_down: boolean
    last_keyboard_event?: KeyboardEvent

    constructor(x:number, y:number, is_touch_down: boolean, keyboard_event?:KeyboardEvent, delta_x?: number, delta_y?: number) {
        this.x = x
        this.y = y
        this.delta_x = delta_x
        this.delta_y = delta_y
        this.is_touch_down = is_touch_down
        this.last_keyboard_event = keyboard_event
    }
}

export enum InteractionType {
    scroll,
    touch_down,
    touch_up,
    touch_move,
    hover,
    tap,
    keydown,
    keyup
}

export type InteractionEventCallback = (i: Interaction, prop: InteractionEvent) => void

export class Subscriber {
    readonly id: string
    readonly fn: InteractionEventCallback
    constructor(id: string, callback: InteractionEventCallback) {
        this.id = id
        this.fn = callback
    }
}

export class Interaction {
    last_keyboard_event?: KeyboardEvent
    private is_touch_down: boolean
    private x_movement_during_touch: number
    static readonly THRESOLD_IS_A_MOVING_TOUCH = 10
    private registry: Map<InteractionType, Subscriber[]> = new Map()
    grapher: Grapher

    constructor(grapher: Grapher) {
        this.grapher = grapher
        this.is_touch_down = false
        document.addEventListener('keydown', ()=>{})
        document.addEventListener('keyup', ()=>{})
        this.grapher.canvas.source.addEventListener('wheel', (ev: WheelEvent) => this.handle_scroll(ev))
        this.grapher.canvas.source.addEventListener('mousedown', (ev: MouseEvent) => this.handle_mouse_down(ev))
        this.grapher.canvas.source.addEventListener('mouseup', (ev: MouseEvent) => this.handle_mouse_up(ev))
        this.grapher.canvas.source.addEventListener('mousemove', (ev: MouseEvent) => this.handle_mouse_move(ev))
        this.registry = new Map()
    }

    register_on_event(event_type: InteractionType, sub: Subscriber): void {
        const vals = this.registry.get(event_type)
        if (vals == undefined) {
            this.registry.set(event_type, [sub])
            return
        }
        this.registry.get(event_type)!.push(sub)
    }

    remove_subscription(event_type: InteractionType, id: string): void {
        const subs = this.registry.get(event_type)
        const index_to_remove = subs?.findIndex((val, _i, _o) => (id == val.id))
        if(index_to_remove == undefined || subs == undefined) return
        subs.splice(index_to_remove, 1)
    }

    private handle_scroll(ev: WheelEvent): void {
        const relative_event = this.build_interaction_event(ev.clientX, ev.clientY, ev.deltaX, ev.deltaY)
        this.call_subscriptors(InteractionType.scroll, relative_event)
    }

    private handle_mouse_down(ev: MouseEvent): void {
        const relative_event = this.build_interaction_event(ev.clientX, ev.clientY)
        this.is_touch_down = true
        this.x_movement_during_touch = 0
        this.call_subscriptors(InteractionType.touch_down, relative_event)
    }

    private handle_mouse_up(ev: MouseEvent): void {
        const relative_event = this.build_interaction_event(ev.clientX, ev.clientY)
        this.is_touch_down = false
        this.call_subscriptors(InteractionType.touch_up, relative_event)
        if(this.x_movement_during_touch < Interaction.THRESOLD_IS_A_MOVING_TOUCH) {
            this.call_subscriptors(InteractionType.tap,  relative_event)
        }
    }

    private handle_mouse_move(ev: MouseEvent): void {
        const relative_event = this.build_interaction_event(ev.clientX, ev.clientY, ev.movementX, ev.movementY)
        if(!this.is_touch_down) {
            this.call_subscriptors(InteractionType.hover, relative_event)
            return
        }
        this.call_subscriptors(InteractionType.touch_move, relative_event)
        this.x_movement_during_touch += ev.movementX
    }

    private call_subscriptors(event_type: InteractionType, prop: any) {
        const subs = this.registry.get(event_type) as Subscriber[]
        if (subs == undefined) return
        for (const sub of subs) {
            sub.fn(this, prop)
        }
    }

    private build_interaction_event(x: number, y: number, delta_x?: number, delta_y?: number) {
        const canvas_source = this.grapher.canvas.source
        const rect = canvas_source.getBoundingClientRect();
        return new InteractionEvent(
            ((x - rect.left) / (rect.right - rect.left)) * canvas_source.width,
            ((y - rect.top) / (rect.bottom - rect.top)) * canvas_source.height,
            this.is_touch_down,
            this.last_keyboard_event,
            delta_x,
            delta_y
        )
    };


}