import { Canvas } from "../canvas"
import { Grapher, InputJSONArray } from "../grapher"
import { Layer } from "../layer"
import { Range } from "../utils/range"

export abstract class DrawTool {
    layer: Layer
    get grapher(): Grapher { return this.layer.grapher }
    get canvas(): Canvas { return this.layer.grapher.canvas }
    
    abstract draw(layer: Layer, canvas: Canvas): void
    abstract getRange(data: InputJSONArray): Range
}