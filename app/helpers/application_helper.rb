module ApplicationHelper
  def admin_edit obj
    rails_admin_edit_path obj.class, obj.id
  end

  def is_admin?
    current_user.is_admin?
  end
end
