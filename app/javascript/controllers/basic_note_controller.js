import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "note", "front", "back" ];

  initialize() {
    this.boundChangeNoteState = this.changeNoteState.bind(this);
    this.boundHandleDragStart = this.handleDragStart.bind(this);
  }

  connect() {
    this.noteTarget.addEventListener("click", this.boundChangeNoteState);
    this.noteTarget.addEventListener("dragstart", this.boundHandleDragStart);
  }

  changeNoteState = () => {
    this.frontTarget.hidden = !this.frontTarget.hidden;
    this.backTarget.hidden = !this.backTarget.hidden;
  }

  handleDragStart(event) {
    event.dataTransfer.setData("text/plain", this.noteTarget.parentNode.parentNode.id);
  }
}
