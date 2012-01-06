ActionController::Routing::Routes.draw do |map|
  
  map.connect "pagelime/:action", :controller => :pagelime_receiver_controller
  
end
