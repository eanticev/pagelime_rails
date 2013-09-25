module Pagelime
  module Rails
    module ViewHelper
      
      def cms_content(&block)
        
        # TODO: How to let pagelime-rack handle this?
        
        # the block contents loaded into a variable
        editable_content  = capture(&block)
        processed_html    = ::Pagelime.process_region(editable_content, request.path)
        
        # tell pagelime-rack NOT to parse response body for whole page.
        # this helper method automatically disables auto-processing, 
        # so all editable areas on this page need to use this helper method.
        ::Rack::Pagelime.disable_processing_for_request(request)
        
        # output the final content
        concat(processed_html)
        
      end
      
    end
  end
end