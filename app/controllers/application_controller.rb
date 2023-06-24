# frozen_string_literal: true

##
# Superclass of the controllers.
class ApplicationController < ActionController::Base
  NOT_FOUND_FLASH_MESSAGE = "The requested resource was not found."

  private

  include SessionsHelper

  def require_turbo_request
    head :forbidden if request.headers["Turbo-Frame"].blank?
  end

  def require_login
    return if logged_in?

    unauthenticated
  end

  def unauthenticated
    head :unauthorized
  end

  def not_found_or_unauthorized
    flash[:alert] = NOT_FOUND_FLASH_MESSAGE
    redirect_to root_path
  end
end
