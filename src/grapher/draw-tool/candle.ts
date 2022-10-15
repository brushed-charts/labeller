import { Canvas } from "../canvas";
import { Grapher, InputJSONArray } from "../grapher";
import { Layer } from "../layer";
import { Range } from "../utils/range";
import { DrawTool } from "./base";

export class Candle implements DrawTool{
    data_ref: string;
    group_ref: string;
    
    draw(layer: Layer) {
        const ctx = layer.grapher.canvas.context
        ctx.fillStyle = "green";
        const data = layer.data
        let cursorX = layer.grapher.canvas.source.width
        for (const candle of data.reverse()) {
            this.draw_candle_wick(cursorX, candle, layer)
            this.draw_candle_body(cursorX, candle, layer)
            cursorX -= layer.grapher.cell_width
        }
    }

    draw_candle_body(cursorX: number, candle: Map<String, any>, layer: Layer) {
        const y_axis = layer.grapher.y_axis
        const open = y_axis.toPixel(candle['open'])
        const close = y_axis.toPixel(candle['close'])
        const ctx = layer.grapher.canvas.context
        const pixel_marging = Grapher.CELL_MARGIN_PERCENT * layer.grapher.cell_width
        const x = cursorX - pixel_marging
        const width = -(layer.grapher.cell_width - pixel_marging*2)
        
        ctx.fillStyle = (open > close) ? 'red' : 'green';
        ctx.fillRect(x, open, width, close - open)
    }

    draw_candle_wick(cursorX: number, candle: Map<String, any>, layer: Layer) { 
        const y_axis = layer.grapher.y_axis
        const high = y_axis.toPixel(candle['high'])
        const low = y_axis.toPixel(candle['low'])
        const ctx = layer.grapher.canvas.context
        const cell_width = layer.grapher.cell_width
        ctx.strokeStyle = 'gray'
        ctx.lineWidth = 1
        ctx.beginPath()
        ctx.moveTo(cursorX - cell_width/2, high)
        ctx.lineTo(cursorX - cell_width/2, low)
        ctx.stroke()
    }

    getRange(input: InputJSONArray): Range {
        let min = Number.MAX_SAFE_INTEGER
        let max = Number.MIN_SAFE_INTEGER
        
        for(const candle of input) {
            const low = candle['low'] as number
            const high = candle['high'] as number
            
            min = Math.min(low, min)
            max = Math.max(high, max)
        }

        return new Range(min, max)
    }

    
}