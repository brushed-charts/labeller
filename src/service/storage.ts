import { Layer } from "../grapher/layer";
import { GraphDrawer } from "./drawer";


export class GraphStorage {
    static store: Map<String, Layer> = new Map()
    

    static upsert(id: string, layer: Layer) {
        this.store.set(id, layer)
        GraphDrawer.refresh()
    }

        
    static get_price_based_template() {
        const price = this.store.get('price')
        if(price == undefined) throw new Error("Can't get a template based on price if price layer is not present in storage");
        const empty_val_list = Layer.extract_timestamp(price)
        return empty_val_list
    }
}