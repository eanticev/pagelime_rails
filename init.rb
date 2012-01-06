# Include hook code here
require "pagelime_rails" 

initialize_pagelime_plugin

=begin

if Rails::VERSION::MAJOR == 2
  initialize_pagelime_plugin
elsif Rails::VERSION::MAJOR == 3
  module Pagelime
    class Railtie < Rails::Railtie
      railtie_name :pagelime
      initializer "pagelime.initialize" do |app|
        initialize_pagelime_plugin
      end
    end
  end
end

=end