// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

// Manipulates the DOM: when a new basic note is added, the Turbo Frame is inserted inside
// a reorderable unit. The new HTML reorderable unit needs to be moved outside of that parent
// and after it.
export default class extends Controller {

  connect() {
    console.log("connected the third one")
    this.reorderableBasicNotesContainerCSSSelector = ".reorderable-basic-note-units-container";
    this.reorderableBasicNoteCSSSelector = ".reorderable-basic-note-unit";
    // Targets the direct child reorderableBasicNote of the container; this means the container
    // can only be up one level from the reorderableBasicNoteUnit div
    this.parentReorderableBasicNoteCSSSelector =
      `${this.reorderableBasicNotesContainerCSSSelector} > ${this.reorderableBasicNoteCSSSelector}`;
    this.placeSelfAfterParentReorderableUnit();
  }

  placeSelfAfterParentReorderableUnit() {
    const parentReorderableNoteUnit = this.element.closest(this.parentReorderableBasicNoteCSSSelector);
    if (parentReorderableNoteUnit !== this.element) {
      parentReorderableNoteUnit.insertAdjacentElement("afterend", this.element);
    }
  }
}
