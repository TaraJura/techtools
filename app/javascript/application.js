// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./channels"

let myDropzone = new Dropzone("form#myId", { url: "/invoices"});
const myModal = document.getElementById('myModal')
const myInput = document.getElementById('myInput')

myModal.addEventListener('shown.bs.modal', () => {
  myInput.focus()
})