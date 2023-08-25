// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropzone"];

  initialize() {
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
    this.articleNotes = document.querySelectorAll(this.reorderableBasicNoteCSSSelector);
    const noteTurboId = event.dataTransfer.getData("text/plain");
    const articleId = document.querySelector("[id^=\"article-\"]").id.split("-").slice(1).join("-");
    const noteId = noteTurboId.split("-").slice(3).join("-");
    this.draggedNote = document.getElementById(noteTurboId);
    this.noteOfDropzone = this.dropzoneTarget.closest(this.reorderableBasicNoteCSSSelector);
    const ordinalPositionsResult = this.draggedNoteAndDropzoneOrdinalPositions();
    this.oldOrdinalPosition = ordinalPositionsResult[0];
    this.newOrdinalPosition = ordinalPositionsResult[1];
    if (this.newOrdinalPosition < this.oldOrdinalPosition) {
      this.newOrdinalPosition += 1;
    }
    if (this.dropDoesNotMoveDraggedNote()) {
      return;
    } else {
      this.handleChangeNoteOrdinalPosition(articleId, noteId);
    }
  }

 draggedNoteAndDropzoneOrdinalPositions() {
    let draggedNotePosition = null;
    let noteOfDropzonePosition = null;
    for (let i = 0; i < this.articleNotes.length; i++) {
      if (!draggedNotePosition && (this.articleNotes[i] === this.draggedNote)) {
        draggedNotePosition = i;
      }
      if (!noteOfDropzonePosition && (this.articleNotes[i] === this.noteOfDropzone)) {
        noteOfDropzonePosition = i;
      }
      if (!!draggedNotePosition && !!noteOfDropzonePosition) {
        break;
      }
    }
    return [draggedNotePosition, noteOfDropzonePosition];
  }

  dropDoesNotMoveDraggedNote() {
    return ((this.oldOrdinalPosition === this.newOrdinalPosition));
  }

  handleChangeNoteOrdinalPosition(articleId, noteId) {
    const url = `/articles/${articleId}/change_note_ordinal_position`;
    const params = {note_id: noteId, new_ordinal_position: this.newOrdinalPosition};
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
        this.updateNoteOrdinalPositionInHTML();
      }
      else {
        console.log("Something went wrong reordering the note (the server response status code was not 200).");
      }
    })
    .catch(() => {
      console.log("Something went wrong in the promise chain (the note may have been successfully reordered).");
    });
  }

  updateNoteOrdinalPositionInHTML() {
    this.noteOfDropzone.insertAdjacentElement("afterend", this.draggedNote);
  }
}
