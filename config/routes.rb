
if Rails::VERSION::MAJOR == 2

  ActionController::Routing::Routes.draw do |map|
    Rails.logger.debug "PAGELIME CMS RAILS PLUGIN: setting up rails 2 routes"
    
    map.connect "pagelime/:action", :controller => :pagelime_receiver_controller  
  end

elsif Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR == 0

  Rails.application.routes.draw do
    Rails.logger.debug "PAGELIME CMS RAILS PLUGIN: setting up rails 3 routes"
    
    match 'pagelime/:action' => 'pagelime_receiver'
  end
  
elsif Rails::VERSION::MAJOR >= 3
  
  Pagelime::Rails::Engine.routes.draw do
    Rails.logger.debug "PAGELIME CMS RAILS PLUGIN: setting up rails 3.1+ routes"
    
    get 'pagelime/:action' => 'pagelime_receiver'
  end

  Rails.application.routes.draw do
    Rails.logger.debug "PAGELIME CMS RAILS PLUGIN: mounting Pagelime in rails 3.1+ routes"
    
    mount Pagelime::Rails::Engine => "/"
  end
  
end