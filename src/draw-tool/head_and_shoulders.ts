import { AnchorLine } from "../grapher/geometry/anchor-line";
import { InputJSONArray } from "../grapher/grapher";
import { Layer } from "../grapher/layer";
import Misc from "../misc";
import { LayerType } from "../service/grapher";
import { GraphStorage } from "../service/storage";
import { DrawTool } from "./draw-tool";

export class HeadAndShoulders extends DrawTool{
    
    constructor() {
        super();
        this.interaction_id = `head_and_shoulder_${Misc.generate_unique_id()}`
        this.ID_PREFIX = 'head_and_shoulders'
        this.PATTERN_POINT = 7
        this.layer_type = LayerType.head_and_shoulders
        this.attach()
        this.reset()
        GraphStorage.get_layers_by_type("s")
    }

    protected define_layer(data_template: InputJSONArray): Layer {
        const tool = new AnchorLine()
        
        return new Layer(this.layer_type, data_template, tool, false)
    }

    
}