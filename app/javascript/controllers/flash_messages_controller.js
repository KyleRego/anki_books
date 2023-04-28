import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "message", "closeIcon" ];

  connect() {
    this.closeIconTarget.addEventListener("click", () => {
      this.messageTarget.classList.add("hidden");
    })
  }
}
