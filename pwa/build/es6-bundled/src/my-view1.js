define(["./my-app.js"],function(_myApp){"use strict";const imageBaseUrl="https://picsum.photos/200?random";class RandomImage extends _myApp.PolymerElement{constructor(){super();this.imageUrl=imageBaseUrl}static get template(){return _myApp.html`
            <img src$={{imageUrl}} alt="A random image"/>
        `}static get properties(){return{refreshFrequency:{type:Number,value:5e3}}}ready(){super.ready();this.setTimer()}setTimer(){setInterval(_=>{this.imageUrl=imageBaseUrl+"&cache_prevention="+Math.floor(1e3*Math.random())},this.refreshFrequency)}}customElements.define("random-image",RandomImage);const imageBaseUrl$1="https://picsum.photos/200?random",refreshFrequency=5e3;class RandomProcessedImage extends _myApp.PolymerElement{static get template(){return _myApp.html`
            <canvas id="original"></canvas>
            <canvas id="randomimage"></canvas>
        `}ready(){super.ready();this._initContext();this._fetchImage();this.startTimer()}startTimer(){setInterval(_=>{console.log("Fetching fresh image");this._fetchImage()},refreshFrequency)}_fetchImage(){let image=new Image;image.crossOrigin="anonymous";image.onload=()=>{this.$.original.getContext("2d").drawImage(image,0,0);this._processImage(image)};image.src=imageBaseUrl$1+"&cache_prevention="+Math.floor(1e3*Math.random())}_processImage(image){let canvas=this.$.randomimage;this.glContext.drawImage(image,0,0);var imageData=this.glContext.getImageData(0,0,canvas.width,canvas.height),data=imageData.data;invertColours(data);applyContrast(data,40);this.glContext.putImageData(imageData,0,0)}_initContext(){let canvas=this.$.randomimage;this.glContext=canvas.getContext("2d")}}customElements.define("random-processed-image",RandomProcessedImage);/* Functions for image manipulation */function invertColours(data){for(var i=0;i<data.length;i+=4){data[i]=255^data[i];// Invert Red
data[i+1]=255^data[i+1];// Invert Green
data[i+2]=255^data[i+2];// Invert Blue
}return data}function truncateColor(value){if(0>value){value=0}else if(255<value){value=255}return value}function applyContrast(data,contrast){for(var factor=259*(contrast+255)/(255*(259-contrast)),i=0;i<data.length;i+=4){data[i]=truncateColor(factor*(data[i]-128)+128);data[i+1]=truncateColor(factor*(data[i+1]-128)+128);data[i+2]=truncateColor(factor*(data[i+2]-128)+128)}}class MyView1 extends _myApp.PolymerElement{static get template(){return _myApp.html`
      <style include="shared-styles">
        :host {
          display: block;
          padding: 10px;
        }
      </style>

      <div class="card">
        <div class="circle">1</div>
        <h1>Random Image with Alterations</h1>
        <p>Display a random image</p>
        <random-processed-image></random-processed-image>
      </div>
    `}}window.customElements.define("my-view1",MyView1)});