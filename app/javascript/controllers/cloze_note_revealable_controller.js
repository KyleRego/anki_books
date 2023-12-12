// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "revealableNote", "revealableNoteBack", "revealableNoteFront" ];

  initialize() {
    this.boundChangeNoteState = this.changeNoteState.bind(this);
  }

  connect() {
    this.revealableNoteTarget.addEventListener("click", this.boundChangeNoteState);
  }

  changeNoteState = () => {
    this.revealableNoteFrontTarget.hidden = !this.revealableNoteFrontTarget.hidden;
    this.revealableNoteBackTarget.hidden = !this.revealableNoteBackTarget.hidden;
  }
}
