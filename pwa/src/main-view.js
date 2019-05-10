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

  ready() {
    super.ready();
    showPaintTimings();
    showDOMTimings();
  }
  
}

function showPaintTimings() {
  if (window.performance) {
    let performance = window.performance;
    let performanceEntries = performance.getEntriesByType('paint');
    performanceEntries.forEach( (performanceEntry, i, entries) => {
      console.log(performanceEntry);
      console.log("The time to " + performanceEntry.name + " was " + performanceEntry.startTime  + " milliseconds.");
    });
  } else {
    console.log('Performance timing isn\'t supported.');
  }  
}

function showDOMTimings(){
  var perfData = window.performance.timing; 
  var pageLoadTime = perfData.domContentLoadedEventEnd - perfData.loadEventStart;
  console.log("Page Load Time: " + pageLoadTime);
  var renderTime = perfData.domComplete - perfData.domLoading;
  console.log("DOM Render Time: " + renderTime)
  console.log(perfData);
}

window.customElements.define('main-view', MainView);
