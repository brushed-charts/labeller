import { Range } from "./utils/range";

export class VirtualAxis {
    virtual_range: Range
    pixel_range: Range


    constructor(pixel_range: Range) {
        this.pixel_range = pixel_range
        this.virtual_range = new Range(Number.MAX_SAFE_INTEGER, Number.MIN_SAFE_INTEGER)
    }

    toPixel(x: number): number {
        const vMin = this.virtual_range.min;
        const vMax = this.virtual_range.max;
        const pMin = this.pixel_range.min;
        const pMax = this.pixel_range.max;
        const pixel = pMax - (x - vMin) / (vMax - vMin) * (pMax - pMin);
        return pixel;
    }

    toVirtual(x: number): number {
        const vMin = this.virtual_range.min;
        const vMax = this.virtual_range.max;
        const pMin = this.pixel_range.min;
        const pMax = this.pixel_range.max;
        const virtual = vMax - (x - pMin) / (pMax - pMin) * (vMax - vMin);
        return virtual;
    }
}