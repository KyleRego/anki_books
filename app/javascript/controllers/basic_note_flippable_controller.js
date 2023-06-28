import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "flippableNote", "flippableNoteBack" ];

  initialize() {
    this.boundChangeNoteState = this.changeNoteState.bind(this);
  }

  connect() {
    this.flippableNoteTarget.addEventListener("click", this.boundChangeNoteState);
    this.flippableNoteTarget.addEventListener("dragstart", this.boundHandleDragStart);
  }

  changeNoteState = () => {
    this.flippableNoteBackTarget.hidden = !this.flippableNoteBackTarget.hidden;
  }

  handleDragStart(event) {
    event.dataTransfer.setData("text/plain", this.flippableNoteTarget.parentNode.parentNode.id);
  }
}
