
module Pagelime
  module Rails
    class Engine < ::Rails::Engine
      engine_name :pagelime
      
      initializer "pagelime.initialize" do |app|
        ::Pagelime::Rails.initialize!
        
        app.middleware.use Rack::Pagelime
      end
    end
  end
end