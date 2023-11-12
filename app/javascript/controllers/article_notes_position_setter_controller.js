// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "notes"];

  connect() {
    const topNavBar = document.querySelector("#top-nav");
    const articleSection = this.contentTarget.closest(".article-section");
    const articleNav = articleSection.querySelector(".article-nav");

    let windowHeight = window.innerHeight;
    let articleNavBarHeight = articleNav.offsetHeight;
    let topNavBarHeight = topNavBar.offsetHeight;
    this.setArticleNotesTop(topNavBarHeight, articleNavBarHeight);
    this.setArticleNotesHeight(windowHeight, topNavBarHeight, articleNavBarHeight);

    const resizeObserver = new ResizeObserver((entries) => {
      windowHeight = window.innerHeight;
      articleNavBarHeight = articleNav.offsetHeight;
      topNavBarHeight = topNavBar.offsetHeight;
      this.setArticleNotesTop(topNavBarHeight, articleNavBarHeight);
      this.setArticleNotesHeight(windowHeight, topNavBarHeight, articleNavBarHeight);
    });

    resizeObserver.observe(topNavBar);
  }

  setArticleNotesTop(topNavBarHeight, articleNavBarHeight) {
    this.notesTarget.style.top = `${topNavBarHeight + articleNavBarHeight}px`;
  }

  setArticleNotesHeight(windowHeight, topNavBarHeight, articleNavBarHeight) {
    this.notesTarget.style.height = `${windowHeight - topNavBarHeight - articleNavBarHeight}px`;
  }
}
