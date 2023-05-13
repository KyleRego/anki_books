import { Controller } from "@hotwired/stimulus"
import { parseCSRFTokenFromHTML } from "./shared_methods";

export default class extends Controller {
  static targets = [ "newBasicNoteFormContainer" ];

  initialize() {
    this.formSubmit = this.handleFormSubmit.bind(this);
  }

  connect() {
    this.formTarget = this.newBasicNoteFormContainerTarget.querySelector("form");
    this.formTarget.addEventListener("submit", this.formSubmit);
  }

  handleFormSubmit(event) {
    event.preventDefault();
    const url = this.formTarget.action;
    const params = { basic_note: { front: this.getFront(), back: this.getBack() }, ordinal_position: this.getOrdinalPosition() };
    const authenticityToken = parseCSRFTokenFromHTML();

    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": authenticityToken,
        "Turbo-frame": "new_basic_note"
      },
      body: JSON.stringify(params),
    }).then((response) => {
      if (response.ok) {
        response.text().then(html => {
          Turbo.renderStreamMessage(html);
          this.newBasicNoteFormContainerTarget.parentNode.hidden = true;
        });
      }
    })
  }

  getFront() {
    const front = this.newBasicNoteFormContainerTarget.querySelector("#basic_note_front");
    return front.value;
  }

  getBack() {
    const back = this.newBasicNoteFormContainerTarget.querySelector("#basic_note_back");
    return back.value;
  }

  getOrdinalPosition() {
    const parentTurboNewNote = this.newBasicNoteFormContainerTarget.closest("[id^='turbo-new-basic-note-']");
    if (parentTurboNewNote === null) {
      return 0;
    }
    const siblingNote = parentTurboNewNote.previousElementSibling;
    const allNotes = document.querySelectorAll("[id^='turbo-basic-note-']");
    let position = null;
    for (let i = 0; i < allNotes.length; i++) {
      if (siblingNote === allNotes[i]) {
        position = i + 1;
        break;
      }
    }
    return position;
  }
}
