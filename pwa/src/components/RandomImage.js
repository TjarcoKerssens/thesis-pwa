import { PolymerElement, html } from '@polymer/polymer/polymer-element.js';

const imageBaseUrl = "https://picsum.photos/200?random";

class RandomImage extends PolymerElement{
    constructor(){
        super();
        this.imageUrl = imageBaseUrl;
    }

    static get template(){
        return html`
            <img src$={{imageUrl}} alt="A random image"/>
        `;
    }

    static get properties(){
        return {
            refreshFrequency: {
                type: Number,
                value: 5000
            }
        }
    }

    ready(){
        super.ready();
        this.setTimer();
    }

    setTimer(){
        setInterval(_=>{
            this.imageUrl = imageBaseUrl + "&cache_prevention=" + Math.floor(Math.random()*1000);
        }, this.refreshFrequency);
    }
}

customElements.define('random-image', RandomImage);