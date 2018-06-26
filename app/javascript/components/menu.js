import {MDCMenu} from '@material/menu';

const menuHTML = document.querySelector('.mdc-menu')
if (menuHTML) {
  const menu = new MDCMenu(menuHTML);
  const menuButtons = document.querySelectorAll('.menu-button');

  for (let i = 0; i < menuButtons.length; i++) {
    menuButtons[i].addEventListener("click", (event) => {
      event.preventDefault();
      menu.open = !menu.open;
    })
  }
}

