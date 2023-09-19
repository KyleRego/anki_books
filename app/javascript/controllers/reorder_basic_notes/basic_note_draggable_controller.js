// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["note"];

  initialize() {
    this.turboBasicNoteIdPrefix = "basic-note-";
    this.turboBasicNoteIdPrefixLength = this.turboBasicNoteIdPrefix.length;
    this.articleNotesAreaSelector = "[id^='article-notes-']";
    this.boundHandleDragStart = this.handleDragStart.bind(this);
  }

  connect() {
    this.noteTarget.addEventListener("dragstart", this.boundHandleDragStart);
  }

  handleDragStart(event) {
    const noteDOMId = this.noteTarget.closest(`[id^='${this.turboBasicNoteIdPrefix}']`).id
    const noteId = noteDOMId.slice(this.turboBasicNoteIdPrefixLength);
    this.articleNotesArea = this.noteTarget.closest(this.articleNotesAreaSelector);
    const sourceArticleId = this.articleNotesArea.id.split("article-notes-").slice(1).join("-");
    const data = {noteId: noteId, sourceArticleId: sourceArticleId}
    event.dataTransfer.setData("text/plain", JSON.stringify(data));
  }
}
