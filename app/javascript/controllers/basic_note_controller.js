import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "note", "front", "back" ];

  connect() {
    this.noteTarget.addEventListener("click", this.changeNoteState)
    this.noteTarget.addEventListener("dragstart", (event) => {
      event.dataTransfer.setData("text/plain", this.noteTarget.parentNode.parentNode.id)
    })
  }

  changeNoteState = () => {
    this.frontTarget.hidden = !this.frontTarget.hidden;
    this.backTarget.hidden = !this.backTarget.hidden;
  }

  disconnect() {
    this.noteTarget.removeEventListener("click", () => this.changeNoteState())
  }
}
