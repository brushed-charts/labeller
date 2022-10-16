import { DrawTool } from "./draw-tool/base"
import { Grapher, InputJSONArray } from "./grapher"
import { Range } from "./utils/range"

export class Layer {
    readonly data: InputJSONArray
    readonly tool: DrawTool
    readonly range: Range
    grapher: Grapher

    constructor(data: InputJSONArray, tool: DrawTool) {
        this.data = data
        this.tool = tool
        this.range = this.tool.getRange(this.data)
    }

    static copy_and_set_data(base: Layer, data: InputJSONArray): Layer {
        return new Layer(data, base.tool)
    }
    
}