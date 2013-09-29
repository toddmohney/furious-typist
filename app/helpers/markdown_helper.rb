module MarkdownHelper
  def markdown_to_html(markdown_string)
    BlueCloth.new(markdown_string).to_html.html_safe
  end
end
