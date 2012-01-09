
if Rails::VERSION::MAJOR == 2

  ActionController::Routing::Routes.draw do |map|
    puts "PAGELIME CMS PLUGIN: setting up rails 2 routes"
    map.connect "pagelime/:action", :controller => :pagelime_receiver_controller  
  end

elsif Rails::VERSION::MAJOR == 3
  
  if Rails::VERSION::MINOR == 0

    puts "PAGELIME CMS PLUGIN: setting up rails 3 routes"
    
    Rails.application.routes.draw do
      match 'pagelime/:action' => 'pagelime_receiver'
    end
    
  else
    
    puts "PAGELIME CMS PLUGIN: setting up rails 3.1 routes"
    
    Pagelime::Engine.routes.draw do
      match 'pagelime/:action' => 'pagelime_receiver'
    end
  
    Rails.application.routes.draw do
      mount Pagelime::Engine => "/"
    end
    
    
  end
  
end