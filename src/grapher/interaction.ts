import { Grapher } from "./grapher";

export class InteractionEvent {
    x: number
    y: number
    is_touch_down: boolean
    last_keyboard_event?: KeyboardEvent

    constructor(x:number, y:number, is_touch_down: boolean, keyboard_event?:KeyboardEvent) {
        this.x = x
        this.y = y
        this.is_touch_down = is_touch_down
        this.last_keyboard_event = keyboard_event
    }
}

export enum InteractionType {
    scroll,
    touch_down,
    touch_up,
    touch_move,
    keydown,
    keyup
}

export type InteractionEventCallback = (i: Interaction, prop: InteractionEvent) => void

export class Interaction {
    last_keyboard_event?: KeyboardEvent
    is_touch_down: boolean 
    private registry: Map<InteractionType, InteractionEventCallback[]> = new Map()
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

    register_on_event(event_type: InteractionType, fn: InteractionEventCallback): void {
        const vals = this.registry[event_type]
        if (vals == undefined) {
            this.registry[event_type] = [fn]
            return
        }
        this.registry[event_type].push(fn)
    }

    private handle_scroll(ev: WheelEvent): void {
        const relative_event = this.build_interaction_event(ev.deltaX, ev.deltaY)
        this.call_subscriptors(InteractionType.scroll, relative_event)
    }

    private handle_mouse_down(ev: MouseEvent): void {
        const relative_event = this.build_interaction_event(ev.clientX, ev.clientY)
        this.is_touch_down = true
        this.call_subscriptors(InteractionType.touch_down, relative_event)
    }

    private handle_mouse_up(ev: MouseEvent): void {
        const relative_event = this.build_interaction_event(ev.clientX, ev.clientY)
        this.is_touch_down = false
        this.call_subscriptors(InteractionType.touch_up, relative_event)
    }

    private handle_mouse_move(ev: MouseEvent): void {
        const relative_event = this.build_interaction_event(ev.movementX, ev.movementY)
        this.call_subscriptors(InteractionType.touch_move, relative_event)
    }

    private call_subscriptors(event_type: InteractionType, prop: any) {
        const subs = this.registry[event_type] as InteractionEventCallback[]
        if (subs == undefined) return
        for (const sub of subs) {
            sub(this, prop)
        }
    }

    private build_interaction_event(x: number, y: number) {
        const canvas_source = this.grapher.canvas.source
        const rect = canvas_source.getBoundingClientRect();
        return new InteractionEvent(
            ((x - rect.left) / (rect.right - rect.left)) * canvas_source.width,
            ((y - rect.top) / (rect.bottom - rect.top)) * canvas_source.height,
            this.is_touch_down,
            this.last_keyboard_event
        )
    };


}