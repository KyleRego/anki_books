// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

// Calculates the value for the top property for a secondary nav
// by what it should be to be below the top nav, which can have
// a different height depending on the screen width
export default class extends Controller {
  static targets = [ "element" ];

  initialize() {
    const articleSection = this.elementTarget.closest(".article-section");
    const articleContentArea = articleSection.querySelector(".article-content-area");
    let articleContentAreaHeight = articleContentArea.offsetHeight;
    this.elementTarget.style.height = `${articleContentAreaHeight}px`;

    const resizeObserver = new ResizeObserver((entries) => {
      articleContentAreaHeight = articleContentArea.offsetHeight;
      this.elementTarget.style.height = `${articleContentAreaHeight}px`;
    });

    resizeObserver.observe(articleContentArea);
  }
}
