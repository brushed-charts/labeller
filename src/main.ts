import './style/main.scss'
import * as oanda_json from './assets/mock/json-oanda.json'
import * as close from './assets/mock/json-oanda-close.json'
import * as volume from './assets/mock/oanda_volume.json'
import Misc from './misc'
import { GrapherMode, GrapherService, LayerType } from './service/grapher'
import { Layer } from './grapher/layer'
import { Candle } from './grapher/geometry/candle'
import { Line } from './grapher/geometry/line'
import { Volume } from './grapher/geometry/volume'
import { GraphStorage } from './service/storage'
import { HeadAndShoulders } from './draw-tool/head_and_shoulders'

/**
 * - Every JSON Input data should have the same length
 * - Each input should be in desc order
 * - No missing data are allowed.
 *      If there is a missing date, the value have to be null
 *      In this way the grapher will interpret it as a "hole" 
 */

async function mock_load(imported_data, id, tool, affect_shared_axis = true) {
    const data = Misc.load_json_from_file(imported_data)
    await Misc.sleep(200)    
    GraphStorage.upsert(id, new Layer(LayerType.static, data, tool, affect_shared_axis))
    GrapherService.set_mode(GrapherMode.head_and_shoulders)
}
GrapherService.init()
mock_load(oanda_json, 'price', new Candle())
mock_load(volume, 'volume', new Volume(), false)
mock_load(close, 'close', new Line())