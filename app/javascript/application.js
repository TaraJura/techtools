// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./channels"


document.addEventListener('turbo:load', () => {
  let currentPath = window.location.pathname;

  if (currentPath == "/isdoc") {
    document.addEventListener('turbo:load', () => {
      let myDropzone = new Dropzone("form#myId", { url: "/invoices"});

      const myModal = document.getElementById('myModal')
      const myInput = document.getElementById('myInput')
    })
  } else if (currentPath == "/storage") {
    let myDropzone = new Dropzone("form#storage", { url: "/storage/file"});
  } else if (currentPath == "/public_storage") {
    let myDropzone = new Dropzone("form#publicStorage", { url: "/public_storage/file"});
  }
})