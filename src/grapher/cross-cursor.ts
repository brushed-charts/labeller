import { Canvas } from "./canvas";
import { Grapher } from "./grapher";
import { Interaction, InteractionEvent, InteractionType, Subscriber } from "./interaction";

export class CrossCursor {
    interaction_id = 'cross_cursor'
    grapher: Grapher 
    last_interaction: InteractionEvent
    color: string = '#FFFFFF40'

    get canvas(): Canvas { return this.grapher.canvas } 
    
    constructor(grapher: Grapher) {
        this.grapher = grapher
        this.grapher.interaction.register_on_event(InteractionType.touch_move, new Subscriber(this.interaction_id, (i, ev) => this.handle_mouse_move(i, ev)))
    }

    handle_mouse_move(i: Interaction, ev: InteractionEvent) {
        this.last_interaction = ev
        this.grapher.update()
    }

    draw() {
        if(this.last_interaction == undefined) return
        const x = this.last_interaction.x
        const y = this.last_interaction.y
        this.canvas.context.strokeStyle = this.color
        this.canvas.context.beginPath()
        this.canvas.context.setLineDash([4, 4])
        this.canvas.context.moveTo(0, y)
        this.canvas.context.lineTo(this.canvas.source.width, y)
        this.canvas.context.stroke()
        this.canvas.context.beginPath()
        this.canvas.context.moveTo(x, 0)
        this.canvas.context.lineTo(x, this.canvas.source.height)
        this.canvas.context.stroke()
        this.canvas.context.setLineDash([])
    }
}