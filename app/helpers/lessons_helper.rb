module LessonsHelper
  def lesson_link_helper l
    html = ''
    if l.published?
      html << "<li>"
    else
      html << "<li class=unpublished>"
    end
    if l == @lesson
      html << "<span class=current>#{l.name}</span>"
    else
      html << link_to((l ? l.name : "dead link"), l)
    end
    html << '</li>'
    puts "lesson_link_helper: #{html}"
    html.html_safe
  end
end
