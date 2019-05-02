import { PolymerElement, html } from '@polymer/polymer/polymer-element.js';

class Location extends PolymerElement{
    static get template (){
        return html`
            <h2>Current location</h2>
            <span>Longitude: [[longitude]]</span>
            <span>Latitude: [[latitude]]</span>
        `;
    }

    ready(){
        super.ready();
        this.startWatchingLocation();
    }

    static get properties(){
        return {
            longitude: {
                type: Number,
                value: 0
            },
            latitude: {
                type: Number,
                value: 0
            }
        }
    }

    startWatchingLocation(){
        let locationOptions = {enableHighAccuracy: true};
        if ("geolocation" in navigator){
            navigator.geolocation.watchPosition(this.updateLocation.bind(this), 
                (error) => {
                    console.log("There was an erorr with watching the location: " + error);
                },  
                locationOptions);
        }
    }

    updateLocation(position){
        this.setProperties({
                longitude: position.coords.longitude, 
                latitude: position.coords.latitude
            });
    }
}

customElements.define('geo-location', Location);