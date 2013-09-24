require 'pagelime-rack'
require 'pagelime'
require 'pagelime/rails'

Pagelime.logger.debug "PAGELIME CMS RAILS PLUGIN: pagelime-rails gem loaded"

# start plugin 
if Rails::VERSION::MAJOR == 2
  
  # TODO: Use pagelime-rack for Rails 2.3+ instead of routes and controllers
  
  require_relative 'pagelime/rails2/routing_extensions'
  
  ActionController::Routing::RouteSet::Mapper.send :include, ::Pagelime::Rails::RoutingExtensions
  
  controllers_path = File.expand_path File.join(File.dirname(__FILE__), 'pagelime', 'rails2', 'controllers')
  
  # add dependencies to load paths
  $LOAD_PATH << controllers_path
  load_paths << controllers_path
  load_once_paths.delete(controllers_path)
  
  Pagelime::Rails.initialize!
  
elsif Rails::VERSION::MAJOR >= 3
  require_relative 'pagelime/rails/engine'
end