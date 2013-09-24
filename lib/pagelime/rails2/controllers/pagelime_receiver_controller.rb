class PagelimeReceiverController < ApplicationController
  
  def index
    ::Rails.logger.debug "PAGELIME RAILS RECEIVER index"
    status, headers, body = Rack::Pagelime.handle_status_check(request)
    
    render :inline => body.string, :status => status
  end
  
  def after_publish_callback
    ::Rails.logger.debug "PAGELIME RAILS RECEIVER after_publish_callback"
    status, headers, body = Rack::Pagelime.handle_publish_callback(request)
    
  	render :inline => body.string, :status => status
  end
end
