# Pagelime
require "routing"

%w{ models controllers helpers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

# wire helper
require "app/helpers/pagelime_helper" 
ActionView::Base.send :include, PagelimeHelper

def fetch_cms_xml(page_path)

	page_key = Base64.encode64(page_path)
	xml_content = Rails.cache.fetch("cms:#{page_key}", :expires_in => 15.days) do
	  puts "NO CACHE... loading xml"
		# set input values
		api_dest = "http://localhost:4834"
		key = ENV['PAGELIME_ACCOUNT_KEY']
		secret = ENV['PAGELIME_ACCOUNT_SECRET']
		api_version = ENV['PAGELIME_HEROKU_API_VERSION']
		req = "apiKey=#{key}&path=#{CGI.escape(page_path)}"
		
		# generate API signature
		signature = Base64.encode64("#{OpenSSL::HMAC.digest('sha1',secret,req)}")
		headers = {'Signature' => signature}
		
		puts "SIGNATURE:" + signature
	
		# get the url that we need to post to
		http = Net::HTTP::new('localhost',4834)
		# send the request
		response = http.request_post("/api/heroku/#{api_version}/content.asmx/PageContent", req, headers)

		# cache the file
		# File.open("#{Rails.root}/tmp/test.cms", 'w') {|f| f.write(response.body) }
		
		xml_content = response.body
		
		xml_content
	end
	
	return xml_content
	
end

def cms_process_html_block(page_path=nil, html="")

    # use nokogiri to replace contents
    doc = Nokogiri::HTML::DocumentFragment.parse(html) 
    doc.css("div.cms-editable").each do |div| 
      
		# Grab client ID
		client_id = div["id"]

		# Load pagelime content
		xml_content = fetch_cms_xml(page_path)
		
		puts "parsing xml"
		soap = Nokogiri::XML::Document.parse(xml_content)
		puts "looking for region: #{client_id}"
		xpathNodes = soap.css("EditableRegion[@ElementID=\"#{client_id}\"]")
		puts "regions found: #{xpathNodes.count}"
		if (xpathNodes.count > 0)
			new_content = xpathNodes[0].css("Html")[0].content()
			
			puts "NEW CONTENT:"
			puts new_content
			
			if (new_content)
				# div.content = "Replaced content"
				div.replace new_content
			end
		end
      
    end
	
	return doc.to_html
end

module PagelimeControllerExtensions

	def acts_as_cms_editable(opts=Hash.new)
		after_filter :cms_process_rendered_body, :except => opts[:except]
		include InstanceMethods
	end

	module InstanceMethods
		def cms_process_rendered_body
			# response contents loaded into a variable
			input_content = response.body
			page_path = request.path
			html = cms_process_html_block(page_path,input_content)
			# output the final content
			response.body = html
		end
	end

end

ActionController::Base.extend PagelimeControllerExtensions