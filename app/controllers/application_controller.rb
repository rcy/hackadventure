class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private

  def current_user
    @current_user ||= CouchPotato.database.load_document(session[:user_id]) if session[:user_id]
  end

end
