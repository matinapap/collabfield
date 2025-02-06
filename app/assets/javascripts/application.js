import { Turbo } from "turbo-rails"
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-loading"

import $ from "jquery"
window.$ = $
window.jQuery = $

import "popper.js"
import "bootstrap"

const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

import "posts/*"
