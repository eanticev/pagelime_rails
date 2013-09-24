module Pagelime
  module Rails
    module ViewHelper
      
      def cms_content(&block)
        
        # the block contents loaded into a variable
        editable_content  = capture(&block)
        processed_html    = ::Pagelime.process_region(editable_content, request.path)
        
        # output the final content
        concat(processed_html)
        
      end
      
    end
  end
end