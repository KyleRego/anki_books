// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
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
