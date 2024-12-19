// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "editorContainer" ];

  connect() {
    this.toolbarTarget = this.editorContainerTarget.querySelector("[id^='trix-toolbar-']");
    this.configureToolbar();
    this.setupHeaderButtonsGroup();
    this.addHeaderButtonsGroupToButtonsRow();
    this.removeOriginalHeadersButton();
    this.changeKeyboardShortcuts();
  }

  configureToolbar() {
    this.toolbarTarget.classList.add("sticky-top");
    this.toolbarTarget.classList.add("z-1");
    this.toolbarTarget.classList.add("bg-white");
    this.toolbarTarget.classList.add("py-2");
    this.toolbarTarget.classList.add("mb-1");
  }

  setupHeaderButtonsGroup() {
    this.headersButtonGroup = document.createElement("span");
    this.headersButtonGroup.setAttribute("class", "trix-button-group");
    const headings = ["1", "2", "3", "4", "5", "6"];
    headings.forEach((heading) => {
      const button = document.createElement("button");
      button.innerText = `H${heading}`;
      button.setAttribute("type", "button");
      button.setAttribute("class", "trix-button");
      button.setAttribute("data-trix-attribute", `heading${heading}`);
      button.setAttribute("title", `H${heading}`);
      button.setAttribute("tabindex", "-1");
      button.setAttribute("data-trix-active", "");
      this.headersButtonGroup.appendChild(button);
    });
  }

  addHeaderButtonsGroupToButtonsRow() {
    const buttonsRow = document.querySelector("div.trix-button-row");
    const secondButtonGroup = buttonsRow.children[1];
    secondButtonGroup.insertBefore(this.headersButtonGroup, secondButtonGroup.firstChild);
    while (this.headersButtonGroup.firstChild) {
      this.headersButtonGroup.parentNode.insertBefore(this.headersButtonGroup.firstChild, this.headersButtonGroup);
    }
    this.headersButtonGroup.parentNode.removeChild(this.headersButtonGroup);
  }

  removeOriginalHeadersButton() {
    this.showHeadersButtonGroup = this.toolbarTarget.querySelector(".trix-button--icon-heading-1");
    this.showHeadersButtonGroup.parentNode.removeChild(this.showHeadersButtonGroup);
  }

  changeKeyboardShortcuts() {
    this.changeRedoButtonKeyboardShortcut();
  }

  changeRedoButtonKeyboardShortcut() {
    const redoButton = document.querySelector("button.trix-button--icon-redo");
    redoButton.setAttribute("data-trix-key", "y");
  }
}
