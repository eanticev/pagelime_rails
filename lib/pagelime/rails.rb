module Pagelime
  module Rails
    module ClassMethods
      def initialize!
        
        ::Rails.logger.debug "PAGELIME CMS RAILS PLUGIN: initializing plugin"
        
        app_path_relative = File.join('..', '..', 'app')
        app_path = File.expand_path File.join(File.dirname(__FILE__), app_path_relative)
        
        # add dependencies to load paths
        %w{ models controllers helpers }.each do |dir|
          path = File.join(app_path, dir)
          $LOAD_PATH << path
          
          if ::Rails::VERSION::MAJOR == 2
            ActiveSupport::Dependencies.load_paths << path
            ActiveSupport::Dependencies.load_once_paths.delete(path)
          elsif ::Rails::VERSION::MAJOR >= 3
            ActiveSupport::Dependencies.autoload_paths << path
            ActiveSupport::Dependencies.autoload_once_paths.delete(path)
          end
        end
        
        # wire controller extensions
        require_relative 'rails/controller_extensions'
        ActionController::Base.extend ControllerExtensions
        
        # wire helper
        require_relative File.join('.', app_path_relative, "helpers", "pagelime_helper")
        ActionView::Base.send :include, PagelimeHelper
        
        configure_pagelime!
      end
      
      def configure_pagelime!
        ::Pagelime.configure do |config|
          config.client_class = ::Pagelime::S3RailsCache
          config.logger       = ::Rails.logger
        end
      end
    end
    
    extend ClassMethods
  end
end