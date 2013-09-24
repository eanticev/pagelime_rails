module Pagelime #:nodoc:
  module Rails2 #:nodoc:
    module RoutingExtensions
      def cms_routes
        @set.add_route "/pagelime/:action", :controller => "pagelime_receiver"
      end
    end
  end
end
