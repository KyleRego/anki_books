// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

import { Controller } from "@hotwired/stimulus";
import hljs from "highlight.js";

export default class extends Controller {
  connect() {
    hljs.configure({ lineNumbers: true });
    this.highlightCodeBlocks();
  }

  highlightCodeBlocks() {
    this.element.querySelectorAll("pre").forEach((block) => {
      hljs.highlightElement(block);
    });
  }
}
