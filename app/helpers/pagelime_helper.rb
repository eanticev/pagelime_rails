module PagelimeHelper
  
  def cms_content(&block)
    # the block contents loaded into a variable
    input_content = capture(&block)
    html          = ::Pagelime.processor.process_fragment(input_content, request.path)
    # output the final content
    concat(html)
    # raw capture(&block) + "<div>hello world</div>"
    # raw "BLA!";
  end
  
end