import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "flippableNote", "flippableNoteBack" ];

  initialize() {
    this.boundChangeNoteState = this.changeNoteState.bind(this);
  }

  connect() {
    this.flippableNoteTarget.addEventListener("click", this.boundChangeNoteState);
  }

  changeNoteState = () => {
    this.flippableNoteBackTarget.hidden = !this.flippableNoteBackTarget.hidden;
  }
}
