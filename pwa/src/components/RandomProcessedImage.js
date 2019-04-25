import { PolymerElement, html } from '@polymer/polymer/polymer-element.js';

const imageBaseUrl = "https://picsum.photos/200?random";
const refreshFrequency = 5000;

class RandomProcessedImage extends PolymerElement{
    static get template(){
        return html`
            <canvas id="original"></canvas>
            <canvas id="randomimage"></canvas>
        `;
    }

    ready(){
        super.ready();
        this._initContext();
        this._fetchImage();
        this.startTimer();
    }

    startTimer(){
        setInterval(_=>{
            console.log("Fetching fresh image");
            this._fetchImage();
        }, refreshFrequency);
    }

    _fetchImage(){
        let image = new Image();
        image.crossOrigin = "anonymous";
        image.onload = () => {
            this.$.original.getContext("2d").drawImage(image,0,0);
            this._processImage(image);
        }
        image.src = imageBaseUrl + "&cache_prevention=" + Math.floor(Math.random()*1000);
    }

    _processImage(image){
        let canvas = this.$.randomimage;
        this.glContext.drawImage(image, 0, 0);
        var imageData = this.glContext.getImageData(0, 0, canvas.width, canvas.height);
        var data = imageData.data;
        invertColours(data);
        applyContrast(data, 40);
        this.glContext.putImageData(imageData, 0, 0);
    }

    _initContext(){
        let canvas = this.$.randomimage;
        this.glContext = canvas.getContext('2d');
    }
}

customElements.define('random-processed-image', RandomProcessedImage);

/* Functions for image manipulation */

function invertColours(data){
    for (var i = 0; i < data.length; i += 4) {
        data[i] = data[i] ^ 255; // Invert Red
        data[i+1] = data[i+1] ^ 255; // Invert Green
        data[i+2] = data[i+2] ^ 255; // Invert Blue
    }
    return data;
}

function truncateColor(value) {
    if (value < 0) {
      value = 0;
    } else if (value > 255) {
      value = 255;
    }
  
    return value;
  }
  
  function applyContrast(data, contrast) {
    var factor = (259.0 * (contrast + 255.0)) / (255.0 * (259.0 - contrast));
  
    for (var i = 0; i < data.length; i+= 4) {
      data[i] = truncateColor(factor * (data[i] - 128.0) + 128.0);
      data[i+1] = truncateColor(factor * (data[i+1] - 128.0) + 128.0);
      data[i+2] = truncateColor(factor * (data[i+2] - 128.0) + 128.0);
    }
  }