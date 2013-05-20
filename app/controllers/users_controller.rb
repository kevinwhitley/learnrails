class UsersController < ApplicationController
  def new # display form to create new user
    @user = User.new
  end
  def create # respond to new user post
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      flash[:success] = "Welcome to the App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show # display an existing user
    @user = User.find(params[:id])
  end
end
