module ApplicationHelper
  def safe_textilize text
    doc = RedCloth.new(text)
#    doc.sanitize_html = true
    doc.to_html.html_safe
  end
end
