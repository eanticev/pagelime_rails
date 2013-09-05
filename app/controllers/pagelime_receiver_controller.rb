class PagelimeReceiverController < ApplicationController
  
  def index
    render :inline => "working", :status => 200
  end
  
  def after_publish_callback
    
    Pagelime.client.clear params[:path]
    Pagelime.clinet.clear_shared

# don't do the prefetch below, as the page isn't done publishing (mySQL transaction hasn't completed) at the point when this gets called  	
=begin
  	begin
  		new_content = fetch_cms_xml(params[:path]);
  	rescue
  	end
=end
  	
  	render :inline => "cache cleared", :status => 200
  	
  end
  
  def after_publish_callback_old
    
    # the page_id will come from the request
    page_id = params[:page_id]
    
    # TODO: use the API to get content    
    uri = URI.parse("http://qa.cms.pagelime.com/API/Account/SOAP/Page.asmx/Get")
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    http.open_timeout = 2
    http.read_timeout = 7
    # http.set_debug_output $stderr
    data = {:apiKey => "0fa155c4-9c42-4df6-856a-5cff6e2ff631", :pageId => page_id}.to_json
    response = http.post(uri.path,data,{"content-type"=>"application/json; charset=utf-8","accept"=>"application/json, text/javascript, */*"})

    page_json = JSON.parse(response.body)
    page_json = page_json["d"]
    
    # try to find existing page
    page = PagelimePage.find_by_page_id(page_id)
    if (page)
      # delete existing content
      page.editable_areas.destroy
      page.meta_data.destroy
    else
      # if no page is found, create a new one
      page = PagelimePage.new
    end

    # set the page data
    page.page_id = page_id
    page.path = page_json[:Path]
    page.title = page_json[:Title]
    page.date_published = DateTime.now
    
    # save the page
    page.save
    
    # for each piece of content
    for page_content_json in page_json["EditableRegions"]
      
      # create the content data
      page_content = PagelimeContent.new
      page_content.client_id = page_content_json[:ClientID]
      page_content.page = page
      page_content.html = page_content_json[:Html]
      
      # save content
      page_content.save
      
    end
    
    # for each piece of meta data
    for metadata_json in page_json["MetaDataJSON"]
      
      # create the content data
      page_metadata = PagelimeMetaData.new
      page_metadata.name = metadata_json[0]
      page_metadata.content = metadata_json[1]
      page_metadata.page = page
      
      # save content
      page_metadata.save
      
    end
    
    # respond with an OK status or CREATED status
    render :status => 200
    
  end
  
end
