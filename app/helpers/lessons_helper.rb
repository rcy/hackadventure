module LessonsHelper
  def lesson_link_helper l
    html = ''
    if l.published?
      html << "<li>"
    else
      html << "<li class=unpublished>"
    end
    if l == @lesson
      html << "<span class=current>#{h(l.pretty_name)}</span>"
    else
      html << link_to((l ? h(l.pretty_name) : "FIXME: dead link"), l, :title => l.name)
    end
    html << '</li>'
    html.html_safe
  end
end
