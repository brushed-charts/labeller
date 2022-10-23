import { Geometry } from "./geometry/base"
import { Grapher, InputJSONArray } from "./grapher"
import { Range } from "./utils/range"


export class Layer {
    readonly data: InputJSONArray
    readonly tool: Geometry
    readonly range: Range
    readonly type: string
    grapher: Grapher
    affect_shared_yaxis = true

    constructor(type: string, data: InputJSONArray, tool: Geometry, affect_shared_axis = true) {
        this.data = data
        this.tool = tool
        this.affect_shared_yaxis = affect_shared_axis
        this.range = this.tool.getRange(this.data)
        this.tool.layer = this
    }

    static copy_and_set_data(base: Layer, data: InputJSONArray): Layer {
        return new Layer(base.type, data, base.tool, base.affect_shared_yaxis)
    }

    static extract_timestamp(base: Layer): InputJSONArray {
        const timestamp_list = Array()
        for(let value of base.data) {
            const ts = {'timestamp': value['timestamp'], 'value': undefined}
            timestamp_list.push(ts)
        }
        return timestamp_list
    }
    
}