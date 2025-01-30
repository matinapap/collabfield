# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "https://cdn.jsdelivr.net/npm/@hotwired/turbo-rails@7.1.0/dist/turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js"
pin "popper.js", to: "https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"