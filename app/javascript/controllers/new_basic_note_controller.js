import { Controller } from "@hotwired/stimulus"

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
    const authenticityToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute("content") ?? null;

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
    // Check if the new note form is under an existing note.
    // If it's not, this note is the first note and ordinal position will be 0.
    const parentDropzone = this.newBasicNoteFormContainerTarget.closest(".note-droppable-area");
    if (!!parentDropzone) {
      const allDropZones = document.querySelectorAll(".note-droppable-area");
      let position = null;
      for (let i = 0; i < allDropZones.length; i++) {
        if (parentDropzone === allDropZones[i]) {
          position = i + 1;
          break;
        }
      }
      return position;
    } else {
      return 0;
    }
  }
}
