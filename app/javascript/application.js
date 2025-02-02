// Anki Books, a note-taking app to organize knowledge,
// is licensed under the GNU Affero General Public License, version 3
// Copyright (C) 2023 Kyle Rego

// Configure your import map in config/importmap.rb.
// Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";
import "bootstrap"
import { Modal } from "bootstrap";

import Trix from "trix";

document.addEventListener("turbo:frame-load", (event) => {
  if (event.target.id === "modal") {
    const modalBackdrop = document.querySelector("div.modal-backdrop");
    if (modalBackdrop) {
      modalBackdrop.remove();
    }

    const modalElement = document.querySelector("#modal .modal");
    if (modalElement) {
      const modalInstance = new Modal(modalElement);
      modalInstance.show();
    }
  }
});

document.addEventListener("turbo:before-stream-render", (event) => {
  if (event.target.getAttribute("target") === "modal") {
    const modalElement = document.querySelector("#modal .modal");
    if (modalElement) {
      const modalInstance = Modal.getInstance(modalElement);
      modalInstance.hide();
    }
  }
});

Trix.config.blockAttributes.heading2 = {
  tagName: "h2",
  terminal: true,
  breakOnReturn: true,
  group: false,
};
Trix.config.blockAttributes.heading3 = {
  tagName: "h3",
  terminal: true,
  breakOnReturn: true,
  group: false,
};
Trix.config.blockAttributes.heading4 = {
  tagName: "h4",
  terminal: true,
  breakOnReturn: true,
  group: false,
};
Trix.config.blockAttributes.heading5 = {
  tagName: "h5",
  terminal: true,
  breakOnReturn: true,
  group: false,
};
Trix.config.blockAttributes.heading6 = {
  tagName: "h6",
  terminal: true,
  breakOnReturn: true,
  group: false,
};
