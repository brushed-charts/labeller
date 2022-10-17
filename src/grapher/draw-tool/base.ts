import { Canvas } from "../canvas"
import { InputJSONArray } from "../grapher"
import { Layer } from "../layer"
import { Range } from "../utils/range"

export abstract class DrawTool {
    abstract draw(layer: Layer, canvas: Canvas): void
    abstract getRange(data: InputJSONArray): Range
}