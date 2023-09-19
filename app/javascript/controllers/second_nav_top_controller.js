// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

// Calculates the value for the top property for a secondary nav
// by what it should be to be below the top nav, which can have
// a different height depending on the screen width
export default class extends Controller {
  static targets = [ "nav" ];

  initialize() {
    const topNavBarHeight = document.querySelector("#top-nav").offsetHeight;
    this.navTarget.style.top = `${topNavBarHeight - 1}px`;
  }
}
