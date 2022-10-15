import { Canvas } from "../canvas"
import { InputJSONArray } from "../grapher"
import { Layer } from "../layer"
import { Range } from "../utils/range"

export abstract class DrawTool {
    data_ref: string
    group_ref: string
    
    abstract draw(layer: Layer, canvas: Canvas): void
    abstract getRange(data: InputJSONArray): Range
}