function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        document.querySelector('#img_prev').setAttribute('style',`cursor: pointer;background-image: url('${e.currentTarget.result}');` );
        document.querySelector('#img_prev i').classList.add('hidden')
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

function addPictureListener(){
  ticketPicture = document.getElementById("ticket_picture");
  if (ticketPicture) {
    ticketPicture.addEventListener("change", (event) => {
      readURL(event.currentTarget);
    })
  }
}

document.addEventListener("DOMContentLoaded", () => {
  addPictureListener();
})
