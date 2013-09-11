require 'pagelime-rack'
require 'pagelime'
require 'pagelime/rails'

Pagelime.logger.debug "PAGELIME CMS RAILS PLUGIN: pagelime-rails gem loaded"

# start plugin 
if Rails::VERSION::MAJOR == 2
  require_relative 'pagelime/rails/routing_extensions'
  
  ActionController::Routing::RouteSet::Mapper.send :include, ::Pagelime::Rails::RoutingExtensions
  # below is not needed in Rails 2 as you can use the map.cms_routes from the routing_extensions
  # require File.join(File.dirname(__FILE__), "/../config/routes.rb")
  Pagelime::Rails.initialize!
elsif Rails::VERSION::MAJOR >= 3
  require_relative 'pagelime/rails/engine'
end