# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Helper module with methods related to sessions.
module SessionsHelper
  ##
  # Returns the currently logged-in user, or nil if no user is logged in
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  ##
  # Returns true if a user is currently logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end
end
