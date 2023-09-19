// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["note"];

  initialize() {
    this.existingBasicNoteTurboFrameSelector = ".existing-basic-note-turbo-frame";
    this.articleNotesAreaSelector = "[id^='article-notes-']";
    this.boundHandleDragStart = this.handleDragStart.bind(this);
  }

  connect() {
    this.noteTarget.addEventListener("dragstart", this.boundHandleDragStart);
  }

  handleDragStart(event) {
    const noteDOMId = this.noteTarget.closest(this.existingBasicNoteTurboFrameSelector).id
    this.articleNotesArea = this.noteTarget.closest(this.articleNotesAreaSelector);
    const sourceArticleId = this.articleNotesArea.id.split("article-notes-").slice(1).join("-");
    const data = {noteDOMId: noteDOMId, sourceArticleId: sourceArticleId}
    event.dataTransfer.setData("text/plain", JSON.stringify(data));
  }
}
