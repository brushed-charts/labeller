import { DrawTool } from "./draw-tool/base"
import { Grapher, InputJSONArray } from "./grapher"
import { Range } from "./utils/range"
import { VirtualAxis } from "./virtual-axis"

export class Layer {
    readonly data: InputJSONArray
    readonly tool: DrawTool
    readonly range: Range
    grapher: Grapher
    affect_shared_yaxis = true

    constructor(data: InputJSONArray, tool: DrawTool, affect_shared_axis = true) {
        this.data = data
        this.tool = tool
        this.range = this.tool.getRange(this.data)
        this.affect_shared_yaxis = affect_shared_axis
    }

    static copy_and_set_data(base: Layer, data: InputJSONArray): Layer {
        return new Layer(data, base.tool, base.affect_shared_yaxis)
    }
    
}