import {MDCTextField} from '@material/textfield';
import {MDCSelect, MDCSelectFoundation} from '@material/select';

function setFormInputs() {
  const textfieldsHTML = document.querySelectorAll('.mdc-text-field');
  const selectsHTML = document.querySelectorAll('.mdc-select');

  if (textfieldsHTML) {
    for (let i = 0; i < textfieldsHTML.length; i++) {
        const textField = new MDCTextField(textfieldsHTML[i]);
    }
  }

  if (selectsHTML) {
    for (let i = 0; i < selectsHTML.length; i++) {
        const select = new MDCSelect(selectsHTML[i]);
    }
  }

}

document.addEventListener("DOMContentLoaded", () => {
  setFormInputs();
  window.setInterval(setFormInputs, 1000);
})
