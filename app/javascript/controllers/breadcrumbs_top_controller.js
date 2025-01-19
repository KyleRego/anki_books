// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2025 Kyle Rego

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "breadcrumbs" ]

    initialize() {
        const topNav = document.querySelector("#top-nav");

        const updateTopOffset = () => {
            const rect = topNav.getBoundingClientRect();
            this.breadcrumbsTarget.style.top = `${rect.height}px`;    
        };

        updateTopOffset();

        const resizeObserver = new ResizeObserver(() => updateTopOffset());
        resizeObserver.observe(topNav);
  }
}
