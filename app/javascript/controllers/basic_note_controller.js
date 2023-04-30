import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "note", "front", "back" ];

  connect() {
    this.noteTarget.addEventListener("click", () => {
      this.frontTarget.hidden = !this.frontTarget.hidden;
      this.backTarget.hidden = !this.backTarget.hidden;
    })
  }
}
