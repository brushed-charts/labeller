import { Canvas } from "../grapher/canvas";
import { Grapher, InputJSONArray } from "../grapher/grapher";
import { Interaction, InteractionEvent, InteractionEventType } from "../grapher/interaction";
import { Layer } from "../grapher/layer";
import { Window } from "../window";

export class GrapherService {
    static obj: Grapher
    private static store: Map<String, Layer> = new Map()
    private static xaxis_len: number
    private static window: Window

    static init(): void {
        this.obj = new Grapher(new Canvas())
        this.window = new Window()
        this.obj.interaction.register_on_event(InteractionEventType.scroll, this.on_scroll)
    }

    static add(id: string, layer: Layer) {
        this.store.set(id, layer)
        this.xaxis_len = layer.data.length
    }

    private static on_scroll(i: Interaction, evt: InteractionEvent) {
        
    }
    
    private static build_windowed_layers(): Layer[] {
        const layers: Layer[] = []
        for(const [id, layer] of this.store) {
            const cut_layer = this.window.make_cut_layer(layer)
            layers.push(cut_layer)
        }
        return layers
    }

    static rebuild(): void {
        const layers = this.build_windowed_layers()
        this.obj.clear()
        for(const layer of layers) {
            this.obj.add(layer)
        }
        this.draw()
    }

    static draw(): void{
        this.obj.update()
    }    
}