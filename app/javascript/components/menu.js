import {MDCMenu} from '@material/menu';
const addListenerToMenus = () => {
  const menuElements = document.querySelectorAll('.mdc-menu')
  if (menuElements) {
    for (let i = 0; i < menuElements.length; i++) {
      const menuHTML = menuElements[i];
      const menu = new MDCMenu(menuHTML);
      const menuButton = menuHTML.parentNode.querySelector('.menu-button');
      menuButton.addEventListener("click", (event) => {
        event.preventDefault();
        menu.open = !menu.open;
      })
    }
  }
}

document.addEventListener("DOMContentLoaded", () => {
  addListenerToMenus();
})
