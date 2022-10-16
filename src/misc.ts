import { InputJSONArray } from "./grapher/grapher";

export default class Misc {
    static load_json_from_file(path: any): InputJSONArray {
        // const file = require(path)
        const json_obj = JSON.parse(JSON.stringify(path))
        const array = json_obj['default']
        return array as InputJSONArray
    }

    static async sleep(ms: number) {
        return new Promise( resolve => setTimeout(resolve, ms) );
    }
}