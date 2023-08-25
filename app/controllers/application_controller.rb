# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Superclass of the controllers.
class ApplicationController < ActionController::Base
  NOT_FOUND_FLASH_MESSAGE = "The requested resource was not found."

  private

  include SessionsHelper

  def require_turbo_request
    head :bad_request if request.headers["Turbo-Frame"].blank?
  end

  def require_login
    return if logged_in?

    session[:redirect_path] = request.fullpath
    redirect_to login_path
  end

  def not_found_or_unauthorized
    redirect_to root_path, flash: { alert: NOT_FOUND_FLASH_MESSAGE }
  end
end
