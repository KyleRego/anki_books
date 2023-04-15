// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

import Trix from "trix"

Trix.config.blockAttributes.heading2 = {
  breakOnReturn: true,
  group: false,
  tagName: "h2",
  terminal: true
}

Trix.config.blockAttributes.heading3 = {
  breakOnReturn: true,
  group: false,
  tagName: "h3",
  terminal: true
}

Trix.config.blockAttributes.heading4 = {
  breakOnReturn: true,
  group: false,
  tagName: "h4",
  terminal: true
}

Trix.config.blockAttributes.heading5 = {
  breakOnReturn: true,
  group: false,
  tagName: "h5",
  terminal: true
}

Trix.config.blockAttributes.heading6 = {
  breakOnReturn: true,
  group: false,
  tagName: "h6",
  terminal: true
}