module ApplicationHelper
  def safe_textilize text
    doc = RedCloth.new(text)
#    doc.sanitize_html = true
    doc.to_html.html_safe
  end

  def avatar_link(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    link_to "http://www.gravatar.com/#{gravatar_id}", :title => "Visit gravatar profile" do
      image_tag "http://gravatar.com/avatar/#{gravatar_id}.png?s=20&d=retro"
    end
  end
end
