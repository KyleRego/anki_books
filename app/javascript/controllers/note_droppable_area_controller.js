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
    this.articleNotes = document.querySelectorAll("[id^=\"turbo-basic-note-\"]");
    const noteTurboId = event.dataTransfer.getData("text/plain");
    const articleId = document.querySelector("[id^=\"article-\"]").id.split("-").slice(1).join("-");
    const noteId = noteTurboId.split("-").slice(3).join("-");
    this.draggedNote = document.getElementById(noteTurboId);
    this.draggedNoteNewNoteSibling = this.draggedNote.nextElementSibling;
    this.noteOfDropzone = this.dropzoneTarget.parentNode.parentNode;
    this.noteOfDropzoneNewNoteSibling = this.noteOfDropzone.nextElementSibling;
    if (!this.noteOfDropzoneNewNoteSibling.classList.contains("new-note-turbo-frame")) {
      this.noteOfDropzoneNewNoteSibling = null;
    }
    const oldOrdinalPosition = this.ordinalPositionInArticleNotesOf(this.draggedNote);
    let newOrdinalPosition = this.ordinalPositionInArticleNotesOf(this.noteOfDropzone);
    if (newOrdinalPosition < oldOrdinalPosition) {
      newOrdinalPosition += 1;
    }
    if (this.dropDoesNotMoveDraggedNote(oldOrdinalPosition, newOrdinalPosition)) {
      return;
    } else {
      this.changeNoteOrdinalPosition(articleId, noteId, newOrdinalPosition);
    }
  }

  // TODO: Iterate through article notes only once and find both ordinal positions rather than iterating
  // through twice--refactor after feature tests are complete. 
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

  dropDoesNotMoveDraggedNote(oldOrdinalPosition, newOrdinalPosition) {
    return ((oldOrdinalPosition === newOrdinalPosition));
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
    .then((response) => {
      if (response.status === 200) {
        if (!!this.noteOfDropzoneNewNoteSibling) {
          this.noteOfDropzoneNewNoteSibling.insertAdjacentElement("afterend", this.draggedNote);
          this.draggedNote.insertAdjacentElement("afterend", this.draggedNoteNewNoteSibling);
        } else {
          this.noteOfDropzone.insertAdjacentElement("afterend", this.draggedNote);
        }
      }
      else {
        console.log("Something went wrong, the server responded with a non-200 status code, and the note was not reordered.");
      }
    })
    .catch(() => {
      console.log("Something went wrong and the note was not reordered.");
    });
  }
}
