import { Grapher } from "./grapher";

export enum InteractionEventType {
    scroll
}

export type InteractionEventCallback = (i: Interaction, prop: any) => void
export class Interaction {
    private registry: Map<InteractionEventType, InteractionEventCallback[]> = new Map()
    grapher: Grapher
    x_scroll_total = 0


    constructor(grapher: Grapher) {
        this.grapher = grapher
        this.grapher.canvas.source.addEventListener('wheel', (ev:WheelEvent) => this.handle_scroll(ev))
        this.registry = new Map()
    }

    private handle_scroll(ev: WheelEvent): void {
        this.x_scroll_total += ev.deltaY
        this.call_subscriptors(InteractionEventType.scroll, ev.deltaY)
    }

    private call_subscriptors(event_type: InteractionEventType, prop: any) {
        const subs = this.registry[event_type] as InteractionEventCallback[]
        if(subs == undefined) return 
        for (const sub of subs) {
            sub(this, prop)
        }
    }

    register_on_event(event_type: InteractionEventType, fn: InteractionEventCallback): void {
        const vals = this.registry[event_type]
        if(vals == undefined) {
            this.registry[event_type] = [fn]
            return
        }
        this.registry[event_type].push(fn)
    }


}