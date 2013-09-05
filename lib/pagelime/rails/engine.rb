
module Pagelime
  module Rails
    class Engine < ::Rails::Engine
      engine_name :pagelime
      # paths["config/routes"] << 'config/routes.rb'
      initializer "pagelime.initialize" do |app|
        ::Pagelime::Rails::Initializer.initialize_pagelime_plugin
      end
    end
  end
end