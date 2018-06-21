import {MDCMenu} from '@material/menu';

const menu = new MDCMenu(document.querySelector('.mdc-menu'));
const menuButtons = document.querySelectorAll('.menu-button');
if (menu && menuButtons) {
  for (let i = 0; i < menuButtons.length; i++) {
    menuButtons[i].addEventListener("click", (event) => {
      event.preventDefault();
      menu.open = !menu.open;
    })
  }
}
