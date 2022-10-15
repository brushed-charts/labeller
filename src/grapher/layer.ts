import { DrawTool } from "./draw-tool/base"
import { Grapher, InputJSONArray } from "./grapher"
import { Range } from "./utils/range"

export class Layer {
    id: string
    data: InputJSONArray
    tool: DrawTool
    grapher: Grapher
    range: Range

    constructor(id: string, data: InputJSONArray, tool: DrawTool) {
        this.id = id
        this.data = data
        this.tool = tool
        this.range = this.tool.getRange(this.data)
    }

    
    
}