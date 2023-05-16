# frozen_string_literal: true

##
# Superclass of the controllers.
class ApplicationController < ActionController::Base
  private

  include SessionsHelper

  def require_turbo_request
    head :forbidden if request.headers["Turbo-Frame"].blank?
  end

  def require_login
    return if logged_in?

    flash[:alert] = "You must be logged in to access this page."
    redirect_to root_path
  end
end
