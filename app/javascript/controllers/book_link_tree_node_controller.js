// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "childrenBookLinkNodes", "expandButton", "unexpandButton" ];

  showHiddenChildBookLinkNodes(event) {
    event.preventDefault();
    event.stopPropagation();
    this.childrenBookLinkNodesTarget.hidden = false;
    this.expandButtonTarget.hidden = true;
    this.unexpandButtonTarget.hidden = false;
  }

  hideShownChildBookLinkNodes(event) {
    event.preventDefault();
    event.stopPropagation();
    this.childrenBookLinkNodesTarget.hidden = true;
    this.expandButtonTarget.hidden = false;
    this.unexpandButtonTarget.hidden = true;
  }
}
