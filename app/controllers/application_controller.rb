# frozen_string_literal: true

##
# Superclass of the controllers.
class ApplicationController < ActionController::Base
  NOT_LOGGED_IN_FLASH_MESSAGE = "You must be logged in to access this page."
  NOT_FOUND_FLASH_MESSAGE = "The requested resource was not found."
  NO_ACCESS_FLASH_MESSAGE = "You do not have access to this page."

  private

  include SessionsHelper

  def require_turbo_request
    head :forbidden if request.headers["Turbo-Frame"].blank?
  end

  def require_login
    return if logged_in?

    redirect_to_homepage_not_logged_in
  end

  def redirect_to_homepage_not_logged_in
    flash[:alert] = NOT_LOGGED_IN_FLASH_MESSAGE
    redirect_to root_path
  end

  def redirect_to_homepage_not_found
    flash[:alert] = NOT_FOUND_FLASH_MESSAGE
    redirect_to root_path
  end

  def redirect_to_homepage_no_access
    flash[:alert] = NO_ACCESS_FLASH_MESSAGE
    redirect_to root_path
  end
end
