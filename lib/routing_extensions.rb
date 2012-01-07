module Pagelime #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def cms_routes
        @set.add_route("/pagelime/:action", {:controller => "pagelime_receiver"})
      end
    end
  end
end

if Rails::VERSION::MAJOR == 2
  ActionController::Routing::RouteSet::Mapper.send :include, Pagelime::Routing::MapperExtensions
end