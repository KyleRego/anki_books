// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "newBasicNoteFormContainer" ];

  initialize() {
    this.reorderableNoteUnitSelector = ".reorderable-note-unit";
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
    const parentReorderableUnit = this.newBasicNoteFormContainerTarget.closest(this.reorderableNoteUnitSelector);
    if (parentReorderableUnit === null) {
      return 0;
    }
    const reorderableNoteUnits = document.querySelectorAll(this.reorderableNoteUnitSelector);
    let position = null;
    for (let i = 0; i < reorderableNoteUnits.length; i++) {
      if (parentReorderableUnit === reorderableNoteUnits[i]) {
        position = i + 1;
        break;
      }
    }

    return position;
  }
}
