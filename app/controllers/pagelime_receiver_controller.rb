class PagelimeReceiverController < ApplicationController
  
  def index
    render :inline => "working", :status => 200
  end
  
  def after_publish_callback
    Pagelime.cache.clear_page params[:path]
    Pagelime.cache.clear_shared

  	render :inline => "cache cleared", :status => 200
  end
end
