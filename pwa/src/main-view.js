import { PolymerElement, html } from '@polymer/polymer/polymer-element.js';
import './components/RandomProcessedImage'
import './components/Location'
import './shared-styles.js';

class MainView extends PolymerElement {
  static get template() {
    return html`
      <style include="shared-styles">
        :host {
          display: block;
          padding: 10px;
        }
      </style>

      <div class="card">
        <h1>Random Image with alterations</h1>
        <p>Display a random image</p>
        <random-processed-image></random-processed-image>
        <geo-location></geo-location>
      </div>
    `;
  }
}

window.customElements.define('main-view', MainView);
