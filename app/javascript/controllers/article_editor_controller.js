import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "editorContainer" ];

  connect() {
    this.toolbarTarget = this.editorContainerTarget.querySelector("[id^='trix-toolbar-']");
    this.setupHeaderButtonsGroup();
    this.changeOriginalHeaderButtonToToggleHeaderButtonsGroup();
    this.toolbarTarget.appendChild(this.headerButtonsRow);
  }

  setupHeaderButtonsGroup() {
    this.headerButtonsRow = document.createElement("div");
    this.headerButtonsRow.setAttribute("class", "trix-button-row");
    this.headerButtonsRow.classList.add("hidden-important");

    this.headersButtonGroup = document.createElement("div");
    this.headersButtonGroup.setAttribute("class", "trix-button-group");
    this.headerButtonsRow.appendChild(this.headersButtonGroup);

    const headings = ["1", "2", "3", "4", "5", "6"];
    headings.forEach((heading) => {
      const button = document.createElement("button");
      button.innerText = `H${heading}`;
      button.setAttribute("type", "button");
      button.setAttribute("class", `trix-button`);
      button.setAttribute("data-trix-attribute", `heading${heading}`);
      button.setAttribute("title", `H${heading}`);
      button.setAttribute("tabindex", "-1");
      button.setAttribute("data-trix-active", "");
      this.headersButtonGroup.appendChild(button);
    });
  }

  changeOriginalHeaderButtonToToggleHeaderButtonsGroup() {
    this.showHeadersButtonGroup = this.toolbarTarget.querySelector(".trix-button--icon-heading-1");
    this.showHeadersButtonGroup.removeAttribute("data-trix-attribute");
    this.showHeadersButtonGroup.removeAttribute("data-trix-active");
    this.showHeadersButtonGroup.classList.remove("trix-active");
    this.showHeadersButtonGroup.setAttribute("title", "Headers");
    this.showHeadersButtonGroup.addEventListener("click", () => this.toggleHeaderButtonsGroupVisibility());
  }

  toggleHeaderButtonsGroupVisibility() {
    this.headerButtonsRow.classList.toggle("hidden-important");
  }
}
