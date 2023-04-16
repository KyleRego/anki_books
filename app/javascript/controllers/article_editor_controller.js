import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "editor" ];

  connect() {
    this.setupHeaderButtons();
    this.toolbarTarget = document.querySelector("[id^='trix-toolbar-']");
    this.changeOriginalHeaderButtonToToggleNewHeaderButtonsRow();
    this.toolbarTarget.appendChild(this.headerButtonsRow);
  }

  changeOriginalHeaderButtonToToggleNewHeaderButtonsRow() {
    this.showHeadersButtonGroup = this.toolbarTarget.querySelector(".trix-button--icon-heading-1");
    this.showHeadersButtonGroup.removeAttribute("data-trix-attribute");
    this.showHeadersButtonGroup.setAttribute("title", "Headers");
    this.showHeadersButtonGroup.addEventListener("click", () => this.toggleHeadersButtonsVisibility());
  }

  toggleHeadersButtonsVisibility() {
    this.headerButtonsRow.classList.toggle("hidden-important");
  }

  setupHeaderButtons() {
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
}
