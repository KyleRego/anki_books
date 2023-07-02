import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["article"];

  initialize() {
    this.boundHandleDragStart = this.handleDragStart.bind(this);
  }

  connect() {
    this.articleTarget.addEventListener("dragstart", this.boundHandleDragStart);
  }

  handleDragStart(event) {
    event.dataTransfer.setData("text/plain", this.articleTarget.id);
  }
}
