module ApplicationHelper
  def safe_textilize text
    doc = RedCloth.new(text)
#    doc.sanitize_html = true
    doc.to_html.html_safe
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=20"
  end
end
