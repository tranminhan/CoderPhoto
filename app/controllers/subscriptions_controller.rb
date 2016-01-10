class SubscriptionsController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    # debugger
    if @user.presence
      @user.opt_in = false
      if @user.save
        # debugger
        redirect_to photos_path, flash: { success: 'Successfully unsubscribe your email from notifications!' }
      else 
        redirect_to photos_path, flash: { error: 'Cannot unsubscribe your email from notifications. Please try again later.' }
      end 
    else 
      redirect_to photos_path, error: 'No user found.'
    end 
  end
end
