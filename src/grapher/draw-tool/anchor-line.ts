import { Layer } from "../layer";
import { Line } from "./line";

export class AnchorLine extends Line {
    readonly radius: number

    constructor(color: string = '#2c7fbf', line_width = 2, radius = 7) {
        super(color, line_width)
        this.radius = radius
    }

    draw(layer: Layer) {
        super.draw(layer)
        this.cursor_x = layer.grapher.canvas.source.width
        for (const json_data of layer.data) {
            const anchor = json_data['value']
            if (anchor) {
                this.draw_anchor(anchor)
            }
            this.cursor_x -= this.layer.grapher.cell_width
        }
    }

    draw_anchor(y_anchor: number) {
        const y_pos = this.y_axis.toPixel(y_anchor)
        const margin = this.layer.grapher.cell_width / 2
        const x = this.cursor_x - margin
        const ctx = this.canvas.context
        ctx.fillStyle = this.color
        ctx.beginPath()
        ctx.arc(x, y_pos, this.radius, 0, 2*Math.PI)
        ctx.fill()
    }

}