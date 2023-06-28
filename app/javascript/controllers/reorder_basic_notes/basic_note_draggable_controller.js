import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["note"];

  initialize() {
    this.boundHandleDragStart = this.handleDragStart.bind(this);
  }

  connect() {
    this.noteTarget.addEventListener("dragstart", this.boundHandleDragStart);
  }

  handleDragStart(event) {
    event.dataTransfer.setData("text/plain", this.noteTarget.parentNode.parentNode.id);
  }
}
