// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

import Trix from "trix"

import hljs from "highlight.js";

hljs.configure({lineNumbers: true})

function highlightCodeBlocks() {
  document.querySelectorAll("pre").forEach((block) => {
    hljs.highlightElement(block);
  });
}
// Note: Using 'turbo:load' instead of 'DOMContentLoaded' to account for Turbo
// Turbo dynamically updates the DOM, so 'DOMContentLoaded' may not capture
// the updated content, whereas 'turbo:load' is triggered after the DOM has been
// updated with new content by Turbo.
document.addEventListener("turbo:load", highlightCodeBlocks);
