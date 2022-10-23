import { AnchorLine } from "../grapher/geometry/anchor-line";
import { InputJSONArray } from "../grapher/grapher";
import { InteractionType } from "../grapher/interaction";
import { Layer } from "../grapher/layer";
import Misc from "../misc";
import { GrapherService, LayerType } from "../service/grapher";
import { GraphStorage } from "../service/storage";
import { DrawTool } from "./draw-tool";

export class HeadAndShoulders extends DrawTool{
    
    constructor() {
        super();
        this.interaction_id = `head_and_shoulder_${Misc.generate_unique_id()}`
        super.ID_PREFIX = 'head_and_shoulders'
        super.PATTERN_POINT = 7
        this.attach()
        this.reset()
    }

    protected create_new_layer(data_template: InputJSONArray): Layer {
        const tool = new AnchorLine()
        const layer_type = LayerType.head_and_shoulders
        return new Layer(layer_type, data_template, tool, false)
    }
    
}