import './style/main.scss'
import * as oanda_json from './assets/mock/json-oanda.json'
import * as oanda_ma_json from './assets/mock/json-oanda-ma.json'
import { Canvas } from './grapher/canvas'
import { Grapher } from './grapher/grapher'
import Misc from './misc'
import { Candle } from './grapher/draw-tool/candle'
import { Layer } from './grapher/layer'


const canvas = new Canvas()
const grapher = new Grapher(canvas)

const mock_price_data = Misc.load_json_from_file(oanda_json)
const mock_ma_data = Misc.load_json_from_file(oanda_ma_json)


grapher.add(new Layer('price', mock_price_data, new Candle()))
grapher.update()