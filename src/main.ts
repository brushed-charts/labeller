import './style/main.scss'
import * as oanda_json from './assets/mock/json-oanda.json'
import * as close from './assets/mock/json-oanda-close.json'
import Misc from './misc'
import { GrapherService } from './service/grapher'
import { Layer } from './grapher/layer'
import { Candle } from './grapher/draw-tool/candle'
import { Line } from './grapher/draw-tool/line'

/**
 * - Every JSON Input data should have the same length
 * - Each input should be in desc order
 * - No missing data are allowed.
 *      If there is a missing date, the value have to be null
 *      In this way the grapher will interpret it as a "hole" 
 */

async function mock_load(imported_data, id, tool) {
    const data = Misc.load_json_from_file(imported_data)
    await Misc.sleep(200)    
    GrapherService.add(id, new Layer(data, tool))
    GrapherService.rebuild()
}
GrapherService.init()
mock_load(oanda_json, 'price', new Candle())
mock_load(close, 'close', new Line())