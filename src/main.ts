import './style/main.scss'
import * as oanda_json from './assets/mock/json-oanda.json'
import Misc from './misc'
import { GrapherService } from './service/grapher'
import { Layer } from './grapher/layer'
import { Candle } from './grapher/draw-tool/candle'

async function mock_load() {
    const data = Misc.load_json_from_file(oanda_json)
    await Misc.sleep(200)    
    GrapherService.add('price', new Layer(data, new Candle()))
    GrapherService.rebuild()
}
GrapherService.init()
mock_load()