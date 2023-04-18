# frozen_string_literal: true

##
# Superclass of the controllers.
class ApplicationController < ActionController::Base
  private

  def require_login
    return if logged_in?

    flash[:alert] = "You must be logged in to access this page."
    redirect_to root_path
  end

  def logged_in?
    session[:user_id]
  end
end
