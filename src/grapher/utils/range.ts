export class Range {
    min: number
    max: number

    constructor(min:number, max: number) {
        this.min = min
        this.max = max
    }

    static extremum(rangeA: Range, rangeB: Range) {
        const min = Math.min(rangeA.min, rangeB.min)
        const max = Math.max(rangeA.max, rangeB.max)
        return new Range(min, max)
    }


}