import {MDCRipple} from '@material/ripple';

function addJSToFabs() {
  const htmlFabs = document.querySelectorAll('.mdc-fab');
  if (htmlFabs) {
    for (let i = 0; i < htmlFabs.length; i++) {
        const fabRipple = new MDCRipple(htmlFabs[i]);
    }
  }
}

document.addEventListener("DOMContentLoaded", () => {
  addJSToFabs();
})
