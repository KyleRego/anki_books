// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "message", "closeIcon" ];

  connect() {
    this.closeIconTarget.addEventListener("click", () => {
      this.messageTarget.classList.add("hidden");
    })
  }
}
