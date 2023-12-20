// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "childrenBookLinkNodes", "expandButton", "unexpandButton" ];

  initialize() {
    this.showHiddenChildBookLinkNodes = this.showHiddenChildBookLinkNodes.bind(this);
    this.hideShownChildBookLinkNodes = this.hideShownChildBookLinkNodes.bind(this);
  }

  connect() {
    this.expandButtonTarget.addEventListener("click", this.showHiddenChildBookLinkNodes);
    this.unexpandButtonTarget.addEventListener("click", this.hideShownChildBookLinkNodes);
  }

  showHiddenChildBookLinkNodes() {
    this.childrenBookLinkNodesTarget.hidden = false;
    this.expandButtonTarget.hidden = true;
    this.unexpandButtonTarget.hidden = false;
  }

  hideShownChildBookLinkNodes() {
    this.childrenBookLinkNodesTarget.hidden = true;
    this.expandButtonTarget.hidden = false;
    this.unexpandButtonTarget.hidden = true;
  }
}
