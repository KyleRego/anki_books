// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropzone"];

  initialize() {
    this.turboBasicNoteIdPrefix = "basic-note-";
    this.turboBasicNoteIdPrefixLength = this.turboBasicNoteIdPrefix.length;
    this.articleNotesAreaSelector = "[id^='article-notes-']";
    this.reorderableBasicNoteCSSSelector = ".reorderable-basic-note-unit";
    this.boundHandleDragEnter = this.handleDragEnter.bind(this);
    this.boundHandleDragLeave = this.handleDragLeave.bind(this);
    this.boundHandleDragOver = this.handleDragOver.bind(this);
    this.boundHandleDrop = this.handleDrop.bind(this);
  }

  connect() {
    this.dropzoneTarget.addEventListener("dragenter", this.boundHandleDragEnter);
    this.dropzoneTarget.addEventListener("dragleave", this.boundHandleDragLeave);
    this.dropzoneTarget.addEventListener("dragover", this.boundHandleDragOver);
    this.dropzoneTarget.addEventListener("drop", this.boundHandleDrop);
    this.nestedDragEnterLevels = 0;
  }

  handleDragEnter(event) {
    event.preventDefault();
    this.nestedDragEnterLevels += 1;
    this.addColorToDropzone();
  }

  addColorToDropzone() {
    this.dropzoneTarget.classList.add("bg-blue-200");
  }

  removeColorFromDropzone() {
    this.dropzoneTarget.classList.remove("bg-blue-200");
  }

  handleDragLeave(event) {
    event.preventDefault();
    this.nestedDragEnterLevels -= 1;
    if (this.nestedDragEnterLevels === 0) {
      this.removeColorFromDropzone();
    }
  }

  handleDragOver(event) {
    event.preventDefault();
    event.dataTransfer.dropEffect = "move";
  }

  handleDrop(event) {
    event.preventDefault();
    this.nestedDragEnterLevels = 0;
    this.removeColorFromDropzone();
    const data = event.dataTransfer.getData("text/plain");
    const noteDOMId = JSON.parse(data)["noteDOMId"];
    const sourceArticleId = JSON.parse(data)["sourceArticleId"];
    const noteId = noteDOMId.slice(this.turboBasicNoteIdPrefixLength);
    this.noteOfDropzone = this.dropzoneTarget.closest(this.reorderableBasicNoteCSSSelector);
    this.articleNotesArea = this.noteOfDropzone.closest(this.articleNotesAreaSelector);
    this.articleNotes = this.articleNotesArea.querySelectorAll(this.reorderableBasicNoteCSSSelector);
    const targetArticleId = this.articleNotesArea.id.split("article-notes-").slice(1).join("-");
    const newOrdinalPosition = this.dropzoneOrdinalPosition();
    let oldOrdinalPosition = null;
    if (sourceArticleId === targetArticleId) {
      this.draggedNote = document.getElementById(noteDOMId).closest(this.reorderableBasicNoteCSSSelector);
      oldOrdinalPosition = this.draggedNoteOrdinalPosition();
    }
    this.handleChangeNoteOrdinalPosition(targetArticleId, noteId, oldOrdinalPosition, newOrdinalPosition);
  }

 dropzoneOrdinalPosition() {
    for (let i = 0; i < this.articleNotes.length; i++) {
      if (this.articleNotes[i] === this.noteOfDropzone) {
        return i;
      }
    }
  }

  draggedNoteOrdinalPosition() {
    for (let i = 0; i < this.articleNotes.length; i++) {
      if (this.articleNotes[i] === this.draggedNote) {
        return i;
      }
    }    
  }

  handleChangeNoteOrdinalPosition(targetArticleId, noteId, oldOrdinalPosition, newOrdinalPosition) {
    const url = `/articles/${targetArticleId}/change_note_ordinal_position`;
    const params = {note_id: noteId, new_ordinal_position: newOrdinalPosition};
    const authenticityToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute("content") ?? null;
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": authenticityToken
      },
      body: JSON.stringify(params),
    })
    .then((response) => {
      if (response.status === 200) {
        this.updateNoteOrdinalPositionInHTML(oldOrdinalPosition, newOrdinalPosition);
      }
      else {
        console.log("Something went wrong reordering the note (the server response status code was not 200).");
      }
    })
    .catch(() => {
      console.log("Something went wrong in the promise chain (the note may have been successfully reordered).");
    });
  }

  updateNoteOrdinalPositionInHTML(oldOrdinalPosition, newOrdinalPosition) {
    // oldOrdinalPosition is null if draggedNote is from a different article
    if (oldOrdinalPosition && (newOrdinalPosition <= oldOrdinalPosition)) {
      this.noteOfDropzone.insertAdjacentElement("beforebegin", this.draggedNote);
    } else {
      this.noteOfDropzone.insertAdjacentElement("afterend", this.draggedNote);
    }
  }
}
