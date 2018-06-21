import "bootstrap";
import "../components/fab.js";
import "../components/textField.js";
import "../components/select.js";
import "../components/imagePreview.js";
import "../components/navbar.js";
import {MDCMenu} from '@material/menu';

const menu = new MDCMenu(document.querySelector('.mdc-menu'));
const menuButtonEl = document.querySelector('#menu-button');
menuButtonEl.addEventListener('click', function() {
    menu.open = !menu.open;
});
