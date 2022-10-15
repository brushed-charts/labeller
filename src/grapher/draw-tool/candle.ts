import { Canvas } from "../canvas";
import { InputJSONArray } from "../grapher";
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
            this.draw_candle_body(cursorX, candle, layer)
            cursorX -= layer.grapher.unit_interval
        }
    }

    draw_candle_body(cursorX: number, candle: Map<String, any>, layer: Layer) {
        const y_axis = layer.grapher.y_axis
        const open = y_axis.toPixel(candle['open'])
        const close = y_axis.toPixel(candle['close'])
        const ctx = layer.grapher.canvas.context
        ctx.fillStyle = (open > close) ? 'red' : 'green';
        ctx.fillRect(cursorX, open, layer.grapher.unit_interval, close - open)
        // console.log(close-open, cursorX)
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