module CommentsHelper
  def comments_for obj
    render :partial => "shared/comments", :locals => {:commentable => obj}
  end
end
