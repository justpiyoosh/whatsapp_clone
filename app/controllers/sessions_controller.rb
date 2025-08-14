class SessionsController < ApplicationController
  def new
    # Just render the view without any complex logic
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to messages_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = 'Invalid username or password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end
end
