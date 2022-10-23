import { Layer } from "../grapher/layer"
import { GrapherService } from "./grapher"
import { GraphStorage } from "./storage"
import { GraphWindow } from "./window"

export class GraphDrawer {
    
    static refresh(): void {
        const layers = this.build_windowed_layers()
        GrapherService.obj.clear()
        this.add_layers_to_grapher(layers)
        GrapherService.obj.update()
    }
    
    private static build_windowed_layers(): Layer[] {
        const layers: Layer[] = []
        for(const [id, layer] of GraphStorage.store) {
            const cut_layer = GraphWindow.make_cut_layer(layer)
            layers.push(cut_layer)
        }
        return layers
    }

    private static add_layers_to_grapher(layer_list: Layer[]) {
        for(const layer of layer_list) {
            GrapherService.obj.add(layer)
        }
    }

}