require 'nokogiri'
require 'openssl'
require 'base64'
require	'cgi'
require 'net/http'

module PagelimeHelper
  
  def cms_content(&block)
    # the block contents loaded into a variable
    input_content = capture(&block)
    page_path = request.path
    html = cms_process_html_block(page_path,input_content)
    # output the final content
    concat(html)
    # raw capture(&block) + "<div>hello world</div>"
    # raw "BLA!";
  end
  
end