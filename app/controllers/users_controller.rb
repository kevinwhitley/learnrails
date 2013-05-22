class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
    
  def new # display form to create new user
    @user = User.new
  end
  def create # respond to new user post
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Welcome to the App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit # show the edit form
    # @user = User.find(params[:id]) -- implied by correct_user filter
  end
  def update # respond to edit user "PUT"
    # @user = User.find(params[:id]) -- implied by correct_user filter
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user  # re-signin since remember token has changed
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show # display an existing user
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
