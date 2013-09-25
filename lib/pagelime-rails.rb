require 'pagelime-rack'
require 'pagelime'
require 'pagelime/rails'

Pagelime.logger.debug "PAGELIME CMS RAILS PLUGIN: pagelime-rails gem loaded"

# Support Rails 2.3+

if Rails::VERSION::MAJOR == 2 && Rails::VERSION::MINOR >= 3
  
  Pagelime::Rails.initialize!
  
  ::Rails.application.config.middleware.use Rack::Pagelime
  
elsif Rails::VERSION::MAJOR >= 3
  require_relative 'pagelime/rails/engine'
end

