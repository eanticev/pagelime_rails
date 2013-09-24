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
        ::Pagelime.configure do |config|
          config.toggle_processing    = "per_request"
          config.logger               = ::Rails.logger
          config.cache                = ::Rails.cache
          config.cache_fetch_options  = { :expires_in => 1.year }
        end
      end
    end
    
    extend ClassMethods
  end
end