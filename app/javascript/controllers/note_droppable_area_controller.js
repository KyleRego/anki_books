import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropzone"]

  connect() {
    this.dropzoneTarget.addEventListener("dragenter", (event) => this.handleDragEnter(event));
    this.dropzoneTarget.addEventListener("dragover", (event) => this.handleDragOver(event));
    this.dropzoneTarget.addEventListener("drop", (event) => this.handleDrop(event));
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
    const noteTurboId = event.dataTransfer.getData("text/plain");
    const parentNode = this.dropzoneTarget.parentNode;
    const draggedNote = document.getElementById(noteTurboId);
    this.insertDraggedNoteBeforeDropzone(parentNode, draggedNote);
    this.insertDropzoneBeforeDroppedNote(parentNode, draggedNote);
    this.removeExtraDroppableAreas();
  }

  insertDraggedNoteBeforeDropzone(parentNode, draggedNote) {
    parentNode.insertBefore(draggedNote, this.dropzoneTarget);
  }

  insertDropzoneBeforeDroppedNote(parentNode, draggedNote) {
    const newDropzone = document.createElement("div")
    newDropzone.setAttribute("class", "note-droppable-area p-4");
    newDropzone.setAttribute("data-controller", "note-droppable-area");
    newDropzone.setAttribute("data-note-droppable-area-target", "dropzone");
    parentNode.insertBefore(newDropzone, draggedNote);
  }

  removeExtraDroppableAreas() {
    const extraDroppableAreas = document.querySelectorAll("div.note-droppable-area + div.note-droppable-area");
    extraDroppableAreas.forEach((element) => element.remove());  
  }
}
