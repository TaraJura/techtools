import { Controller } from "@hotwired/stimulus"
import Dropzone from "dropzone"

export default class extends Controller {

  static targets = ["dropzoneid"]
  static values = { path: String }

  connect() {
    console.log(this.pathValue)
    new Dropzone(this.dropzoneidTarget, {
      url: this.pathValue,
      headers: { "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content }
    });
  }
}
