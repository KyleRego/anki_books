import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropzone"];

  initialize() {
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
  }

  handleDragEnter(event) {
    event.preventDefault();
    this.addColorToDropzone();
  }

  // TODO: Look into how to not duplicate this with reordering basic notes controller
  addColorToDropzone() {
    this.dropzoneTarget.classList.add("bg-blue-200");
  }

  removeColorFromDropzone() {
    this.dropzoneTarget.classList.remove("bg-blue-200");
  }

  handleDragLeave(event) {
    event.preventDefault();
    this.removeColorFromDropzone();
  }

  handleDragOver(event) {
    event.preventDefault();
    event.dataTransfer.dropEffect = "move";
  }

  handleDrop(event) {
    event.preventDefault();
    this.removeColorFromDropzone();
    const articleId = event.dataTransfer.getData("text/plain");
    const allDraggableArticles = document.querySelectorAll("[data-reorder-articles--article-draggable-target=\"article\"]")
    // getElementById is used here because querySelector does not yet support CSS selector for id that starts with a digit
    this.draggedArticleTarget = document.getElementById(`${articleId}`);
    this.oldOrdinalPosition = this.getOrdinalPosition(this.draggedArticleTarget, allDraggableArticles);

    const allArticleDropzones = document.querySelectorAll("[data-reorder-articles--article-dropzone-target=\"dropzone\"]")
    this.newOrdinalPosition = this.getOrdinalPosition(this.dropzoneTarget, allArticleDropzones);

    if (this.newOrdinalPosition < this.oldOrdinalPosition) {
      this.newOrdinalPosition += 1;
    }
    
    if (this.dropDoesNotMoveDraggedNote()) {
      return;
    } else {
      const bookId = document.querySelector("[id^=\"book-\"]").id.split("-").slice(1).join("-");
      this.handleChangeArticleOrdinalPosition(bookId, articleId);
    }
  }

  getOrdinalPosition(targetToFindIndexOf, allPossibleTargets) {
    let result = 0;
    for (let i = 0; i < allPossibleTargets.length; i++) {
      if (allPossibleTargets[i] === targetToFindIndexOf) {
        result = i;
        break;
      }
    }
    return result;
  }

  dropDoesNotMoveDraggedNote() {
    return (this.oldOrdinalPosition === this.newOrdinalPosition);
  }

  handleChangeArticleOrdinalPosition(bookId, articleId) {
    const url = `/books/${bookId}/change_article_ordinal_position`;
    const params = {article_id: articleId, new_ordinal_position: this.newOrdinalPosition};
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
        this.updateArticleOrdinalPositionInHTML();
      }
      else {
        console.log("Something went wrong reordering the article (the server response status code was not 200).");
      }
    })
    .catch(() => {
      console.log("Something went wrong in the promise chain (the article may have been successfully reordered).");
    });
  }

  updateArticleOrdinalPositionInHTML() {
    const parentDivOfDraggedArticle = this.draggedArticleTarget.closest(".reorderable-unit");
    const parentDivOfDropzoneTarget = this.dropzoneTarget.closest(".reorderable-unit");
    parentDivOfDropzoneTarget.insertAdjacentElement("afterend", parentDivOfDraggedArticle);
  }
}
