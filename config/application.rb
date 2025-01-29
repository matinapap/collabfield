require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Collabfield
  class Application < Rails::Application
    # Αρχικοποίηση των προεπιλεγμένων ρυθμίσεων για τη γεννήτρια της έκδοσης Rails.
    config.load_defaults 8.0

    # Ρύθμιση του Asset Pipeline μέσα στο after_initialize για να διασφαλίσουμε ότι όλα έχουν φορτωθεί
    config.after_initialize do
      Rails.application.config.assets.configure do |env|
        env.export_concurrent = false
      end
    end

    ENV['GOOGLE_CLIENT_ID'] = "your_google_client_id"
ENV['GOOGLE_CLIENT_SECRET'] = "your_google_client_secret"

    # Άλλες ρυθμίσεις...
  end
end
