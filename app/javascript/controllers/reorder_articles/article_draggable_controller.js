import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["article"];

  initialize() {
    this.boundHandleDragStart = this.handleDragStart.bind(this);
  }

  connect() {
    console.log("connected")
    this.articleTarget.addEventListener("dragstart", this.boundHandleDragStart);
  }

  handleDragStart(event) {
    console.log("drag event started")
    event.dataTransfer.setData("text/plain", this.articleTarget.id);
  }
}
