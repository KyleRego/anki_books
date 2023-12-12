// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "flippableNote", "flippableNoteBack" ];

  initialize() {
    this.boundChangeNoteState = this.changeNoteState.bind(this);
  }

  connect() {
    this.flippableNoteTarget.addEventListener("click", this.boundChangeNoteState);
    this.flippableNoteTarget.addEventListener("focus", this.boundChangeNoteState);
  }

  changeNoteState = () => {
    this.flippableNoteBackTarget.hidden = !this.flippableNoteBackTarget.hidden;
  }
}
