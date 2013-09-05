module Pagelime
  module Rails
    module ControllerExtensions
    
      def acts_as_cms_editable(opts = {})
        after_filter :cms_process_rendered_body, :except => opts[:except]
        include InstanceMethods
      end
    
      module InstanceMethods
        def cms_process_rendered_body
          puts "PAGELIME CMS PLUGIN: Processing response body"
          
          # parse response body, cache, and use result as response body
          response.body = Pagelime.processor.process_document(response.body, request.path)
        end
      end
    
    end
  end
end