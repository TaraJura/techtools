// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

let myDropzone = new Dropzone("form#myId", { url: "/invoices"});
