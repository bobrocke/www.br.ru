# Load the Rails application.
require_relative "application"

Rails.application.config.hosts << "bobrock.heliohost.us"

# Initialize the Rails application.
Rails.application.initialize!
