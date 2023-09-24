# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/actiontext", to: "actiontext.js"
pin "highlight.js", to: "https://ga.jspm.io/npm:highlight.js@11.7.0/es/index.js"
pin "trix", to: "https://ga.jspm.io/npm:trix@2.0.6/dist/trix.esm.min.js"
