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
    const topNavBar = document.querySelector("#top-nav");
    let topNavBarHeight = topNavBar.offsetHeight;
    this.elementTarget.style.top = `${topNavBarHeight - 1}px`;

    const resizeObserver = new ResizeObserver((entries) => {
      topNavBarHeight = topNavBar.offsetHeight;
      this.elementTarget.style.top = `${topNavBarHeight - 1}px`;
    });

    resizeObserver.observe(topNavBar);
  }
}
