module Pagelime
  module Rails
    module ClassMethods
      def initialize!
        
        ::Rails.logger.debug "PAGELIME CMS RAILS PLUGIN: initializing plugin"
        
        # wire controller extensions
        require_relative 'rails/controller_extensions'
        ActionController::Base.extend ControllerExtensions
        
        # wire helper
        require_relative 'rails/view_helper'
        ActionView::Base.send :include, ViewHelper
        
        configure_pagelime!
      end
      
      def configure_pagelime!
        assets = ::Rails.application.config.assets
        
        ::Pagelime.configure do |config|
          config.toggle_processing    = "per_request"
          config.logger               = ::Rails.logger
          config.cache_fetch_options  = { :expires_in => 1.year }
          config.cache                = ::Rails.cache
          
          if assets.enabled == true
            
            # fallback on asset logger if available
            config.logger ||= assets.logger if assets.logger != false
            
            # fallback on asset cache_store if available
            config.cache ||= ActiveSupport::Cache.lookup_store(assets.cache_store) if assets.cache_store != false
            
          end
          
        end
      end
    end
    
    extend ClassMethods
  end
end