// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "notes" ];

  connect() {
    const topNavBar = document.querySelector("#top-nav");
    const articleSection = this.contentTarget.closest(".article-section");
    const articleNav = articleSection.querySelector(".article-nav");

    let windowHeight = window.innerHeight;
    let articleNavBarHeight = articleNav.offsetHeight;
    let topNavBarHeight = topNavBar.offsetHeight;
    this.notesTarget.style.top = `${topNavBarHeight + articleNavBarHeight}px`;
    this.notesTarget.style.height = `${windowHeight - topNavBarHeight - articleNavBarHeight}px`

    const resizeObserver = new ResizeObserver((entries) => {
      windowHeight = window.innerHeight;
      articleNavBarHeight = articleNav.offsetHeight;
      topNavBarHeight = topNavBar.offsetHeight;
      this.notesTarget.style.top = `${topNavBarHeight + articleNavBarHeight}px`;
      this.notesTarget.style.height = `${windowHeight - topNavBarHeight - articleNavBarHeight}px`
    });

    resizeObserver.observe(topNavBar);
  }
}
