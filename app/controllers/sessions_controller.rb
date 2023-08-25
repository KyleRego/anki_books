# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# SessionsController handles user login and logout functionality.
class SessionsController < ApplicationController
  def new
    return unless logged_in?

    flash[:notice] = "You are logged in already."
    redirect_to root_path
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_after_login
    else
      redirect_to login_path, flash: { alert: "Invalid email or password." }
    end
  end

  def destroy
    if logged_in?
      session[:user_id] = nil
      flash[:notice] = "Logged out successfully."
      redirect_to root_path
    else
      head :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def redirect_after_login
    redirect_path = session[:redirect_path]
    if redirect_path
      session[:redirect_path] = nil
      redirect_to redirect_path, flash: { notice: "Logged in successfully." }
    else
      redirect_to root_path, flash: { notice: "Logged in successfully." }
    end
  end
end
