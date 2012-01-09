# Pagelime

require "config/routes"
require "routing_extensions"

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
=begin
    class Engine < Rails::Engine
      engine_name :pagelime
      paths.config.routes = 'lib/config/routes.rb'
    end
=end
  end
end

def pagelime_environment_configured?
  ENV['PAGELIME_ACCOUNT_KEY'] != nil &&
  ENV['PAGELIME_ACCOUNT_SECRET'] != nil &&
  ENV['PAGELIME_HEROKU_API_VERSION']
end

def fetch_cms_xml(page_path)

	page_key = Base64.encode64(page_path)
	xml_content = Rails.cache.fetch("cms:#{page_key}", :expires_in => 15.days) do
	  puts "PAGELIME CMS PLUGIN: NO CACHE... loading xml"
		# set input values
		key = ENV['PAGELIME_ACCOUNT_KEY']
		secret = ENV['PAGELIME_ACCOUNT_SECRET']
		api_version = ENV['PAGELIME_HEROKU_API_VERSION']
		req = "apiKey=#{key}&path=#{CGI.escape(page_path)}"
		
		# generate API signature
		signature = Base64.encode64("#{OpenSSL::HMAC.digest('sha1',secret,req)}")
		headers = {'Signature' => signature}
		
		puts "PAGELIME CMS PLUGIN: SIGNATURE:" + signature
	
		# get the url that we need to post to
		http = Net::HTTP::new('qa.cms.pagelime.com',80)
		
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

    begin

      unless pagelime_environment_configured?
        puts "PAGELIME CMS PLUGIN: Environment variables not configured"
        return html
      end
  
      # use nokogiri to replace contents
      doc = Nokogiri::HTML::DocumentFragment.parse(html) 
      doc.css("div.cms-editable").each do |div| 
        
  		# Grab client ID
  		client_id = div["id"]
  
  		# Load pagelime content
  		xml_content = fetch_cms_xml(page_path)
  		
  		puts "PAGELIME CMS PLUGIN: parsing xml"
  		soap = Nokogiri::XML::Document.parse(xml_content)
  		puts "PAGELIME CMS PLUGIN: looking for region: #{client_id}"
  		xpathNodes = soap.css("EditableRegion[@ElementID=\"#{client_id}\"]")
  		puts "regions found: #{xpathNodes.count}"
  		if (xpathNodes.count > 0)
  			new_content = xpathNodes[0].css("Html")[0].content()
  			
  			puts "PAGELIME CMS PLUGIN: NEW CONTENT:"
  			puts new_content
  			
  			if (new_content)
  				# div.content = "Replaced content"
  				div.replace new_content
  			end
  		end
        
      end
      
      return doc.to_html
    
    rescue
      
      # error
      puts "PAGELIME CMS PLUGIN: Error rendering block"
      
      # comment below to disable debug
      raise
      
      return html
      
    end
	  
end

module PagelimeControllerExtensions

	def acts_as_cms_editable(opts=Hash.new)
		after_filter :cms_process_rendered_body, :except => opts[:except]
		include InstanceMethods
	end

	module InstanceMethods
		def cms_process_rendered_body
      puts "PAGELIME CMS PLUGIN: Processing response body"
		  if pagelime_environment_configured?
  			# response contents loaded into a variable
  			input_content = response.body
  			page_path = request.path
  			html = cms_process_html_block(page_path,input_content)
  			# output the final content
  			response.body = html
			else
        puts "PAGELIME CMS PLUGIN: Environment variables not configured"
      end
		end
	end

end

def initialize_pagelime_plugin
  
  puts "PAGELIME CMS PLUGIN: initializing"
  
  # add dependencies to load paths
  %w{ models controllers helpers }.each do |dir|
    path = File.join(File.dirname(__FILE__), 'app', dir)
    $LOAD_PATH << path
    
    if Rails::VERSION::MAJOR == 2
      ActiveSupport::Dependencies.load_paths << path
      ActiveSupport::Dependencies.load_once_paths.delete(path)
    elsif Rails::VERSION::MAJOR == 3
      ActiveSupport::Dependencies.autoload_paths << path
      ActiveSupport::Dependencies.autoload_once_paths.delete(path)
    end
  end
  
  # wire controller extensions
  ActionController::Base.extend PagelimeControllerExtensions
  
  # wire helper
  require "app/helpers/pagelime_helper" 
  ActionView::Base.send :include, PagelimeHelper
  
end