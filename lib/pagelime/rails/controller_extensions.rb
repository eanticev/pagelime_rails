module Pagelime
  module Rails
    module ControllerExtensions
    
      def acts_as_cms_editable(opts = {})
        after_filter :cms_process_rendered_body, :except => opts[:except]
        include InstanceMethods
      end
    
      module InstanceMethods
        def cms_process_rendered_body
          ::Rails.logger.debug "PAGELIME CMS RAILS PLUGIN: Processing response body in controller"
          
          # tell pagelime-rack to parse response body, cache, and use result as response body
          ::Rack::Pagelime.enable_processing_for_request(request.env)
        end
      end
    
    end
  end
end