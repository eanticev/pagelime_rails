
if Rails::VERSION::MAJOR == 2

  ActionController::Routing::Routes.draw do |map|
    puts "PAGELIME CMS PLUGIN: setting up rails 2 routes"
    map.connect "pagelime/:action", :controller => :pagelime_receiver_controller  
  end

elsif Rails::VERSION::MAJOR == 3

  puts "PAGELIME CMS PLUGIN: setting up rails 3 routes"
    
  Pagelime::Engine.routes.draw do
    match 'pagelime/:action' => 'pagelime_receiver'
  end

  Rails.application.routes.draw do
    mount Pagelime::Engine => "/"
  end
  
end