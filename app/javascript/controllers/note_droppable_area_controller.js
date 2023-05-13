import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropzone"];

  initialize() {
    this.turboBasicNoteIdPrefixSelector = "[id^=\"turbo-basic-note-\"]";
    this.boundHandleDragEnter = this.handleDragEnter.bind(this);
    this.boundHandleDragOver = this.handleDragOver.bind(this);
    this.boundHandleDrop = this.handleDrop.bind(this);
  }

  connect() {
    this.dropzoneTarget.addEventListener("dragenter", this.boundHandleDragEnter);
    this.dropzoneTarget.addEventListener("dragover", this.boundHandleDragOver);
    this.dropzoneTarget.addEventListener("drop", this.boundHandleDrop);
  }

  handleDragEnter(event) {
    event.preventDefault();
  }

  handleDragOver(event) {
    event.preventDefault();
    event.dataTransfer.dropEffect = "move";
  }

  handleDrop(event) {
    event.preventDefault();
    this.articleNotes = document.querySelectorAll(this.turboBasicNoteIdPrefixSelector);
    const noteTurboId = event.dataTransfer.getData("text/plain");
    const articleId = document.querySelector("[id^=\"article-\"]").id.split("-").slice(1).join("-");
    const noteId = noteTurboId.split("-").slice(3).join("-");
    this.draggedNote = document.getElementById(noteTurboId);
    this.draggedNoteNewNoteSibling = this.draggedNote.nextElementSibling;
    this.noteOfDropzone = this.dropzoneTarget.closest(this.turboBasicNoteIdPrefixSelector);
    this.noteOfDropzoneNewNoteSibling = this.noteOfDropzone.nextElementSibling;
    if (!this.noteOfDropzoneNewNoteSibling.classList.contains("new-note-turbo-frame")) {
      this.noteOfDropzoneNewNoteSibling = null;
    }
    this.oldOrdinalPosition = this.ordinalPositionInArticleNotesOf(this.draggedNote);
    this.newOrdinalPosition = this.ordinalPositionInArticleNotesOf(this.noteOfDropzone);
    if (this.newOrdinalPosition < this.oldOrdinalPosition) {
      this.newOrdinalPosition += 1;
    }
    if (this.dropDoesNotMoveDraggedNote()) {
      return;
    } else {
      this.changeNoteOrdinalPosition(articleId, noteId);
    }
  }

  // TODO: Iterate through article notes only once and find both ordinal positions rather than iterating
  // through twice--refactor after feature tests are complete.
  // Or extract this method into something shared in the other controllers because the same thing is
  // done elsewhere.
  ordinalPositionInArticleNotesOf(targetElement) {
    let position = null;
    for (let i = 0; i < this.articleNotes.length; i++) {
      if (this.articleNotes[i] === targetElement) {
        position = i;
        break;
      }
    }
    return position;
  }

  dropDoesNotMoveDraggedNote() {
    return ((this.oldOrdinalPosition === this.newOrdinalPosition));
  }

  changeNoteOrdinalPosition(articleId, noteId) {
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
        console.log("Something went wrong reordering the note (the status code was not 200).");
      }
    })
    .catch(() => {
      console.log("Something went wrong reordering the note (an error in the promise chain).");
    });
  }

  updateNoteOrdinalPositionInHTML() {
    if (!!this.noteOfDropzoneNewNoteSibling) {
      console.log(this.newOrdinalPosition);
      console.log(this.oldOrdinalPosition);
      if (this.newOrdinalPosition === 1 && this.oldOrdinalPosition === 0) {
        this.noteOfDropzoneNewNoteSibling.insertAdjacentElement("beforebegin", this.draggedNote);
        this.draggedNote.insertAdjacentElement("beforebegin", this.draggedNoteNewNoteSibling);
      } else {
        this.noteOfDropzoneNewNoteSibling.insertAdjacentElement("afterend", this.draggedNote);
        this.draggedNote.insertAdjacentElement("afterend", this.draggedNoteNewNoteSibling);
      }
    } else {
      this.noteOfDropzone.insertAdjacentElement("afterend", this.draggedNote);
    }
  }
}
