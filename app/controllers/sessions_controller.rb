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
      redirect_to root_path, flash: { notice: "Logged in successfully." }
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
end
