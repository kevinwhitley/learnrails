class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user
      # go wherever the user intended to go (if they weren't signed in)
      # or else to the user's page
      redirect_back_or user
    else
      # Create an error message and re-render the signin form.
      # use flash.now instead of flash, because we're doing an internal render
      # rather then a redirect_to (browser redirect?)
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
