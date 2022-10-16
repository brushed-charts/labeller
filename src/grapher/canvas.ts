export class Canvas {
    source: HTMLCanvasElement
    context: CanvasRenderingContext2D

    constructor() {
        const canvasHTML = document.getElementsByTagName('canvas') 
        if(canvasHTML.length == 0) {
            throw new ReferenceError("<canvas> tag element doesn't exist in HTML page");
        }

        this.source = canvasHTML[0]
        this.context = this.source.getContext('2d')!
        this.adjust_size()
    }

    private adjust_size(): void {
        this.source.width = this.source.clientWidth;
        this.source.height = this.source.clientHeight;
    }

    clear(): void {
        this.context.clearRect(0, 0, this.source.width, this.source.height)
    }
}