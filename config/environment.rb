# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
# Croljobs.application.initialize!

Croljobs::Application.default_url_options = Croljobs::Application.config.action_mailer.default_url_options
