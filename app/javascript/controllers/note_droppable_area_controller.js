import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropzone"];

  initialize() {
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
    this.articleNotes = document.querySelectorAll("[id^=\"basic-note-\"]");
    const noteTurboId = event.dataTransfer.getData("text/plain");
    const articleId = document.querySelector("[id^=\"article-\"]").id.split("-").slice(1).join("-");
    const noteId = noteTurboId.split("-").slice(2).join("-");
    this.draggedNote = document.getElementById(noteTurboId);
    const oldOrdinalPosition = this.ordinalPositionInArticleNotesOf(this.draggedNote);
    const newOrdinalPosition = this.ordinalPositionInArticleNotesOf(this.dropzoneTarget.parentNode);
    if (this.dropDoesNotMoveDraggedNote(oldOrdinalPosition, newOrdinalPosition)) {
      return;
    } else {
      this.changeNoteOrdinalPosition(articleId, noteId, newOrdinalPosition);
    }
  }

  // TODO: Iterate through article notes only once and find both ordinal positions rather than iterating
  // through twice--refactor after feature tests are complete. 
  ordinalPositionInArticleNotesOf(note) {
    let position = null;
    for (let i = 0; i < this.articleNotes.length; i++) {
      if (this.articleNotes[i] === note) {
        position = i;
        break;
      }
    }
    return position;
  }

  dropDoesNotMoveDraggedNote(oldOrdinalPosition, newOrdinalPosition) {
    return ((oldOrdinalPosition === newOrdinalPosition) || ((oldOrdinalPosition - 1) === newOrdinalPosition));
  }

  changeNoteOrdinalPosition(articleId, noteId, newOrdinalPosition) {
    const url = `/articles/${articleId}/change_note_ordinal_position`;
    const params = {note_id: noteId, new_ordinal_position: newOrdinalPosition};
    const authenticityToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": authenticityToken
      },
      body: JSON.stringify(params),
    })
    .then(() => {
      this.dropzoneTarget.parentNode.insertAdjacentElement("afterend", this.draggedNote);
    })
    .catch(() => {
      console.log("Something went wrong reordering the notes.");
    });
  }
}
