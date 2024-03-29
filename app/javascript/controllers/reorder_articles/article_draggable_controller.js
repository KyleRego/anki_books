// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

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
