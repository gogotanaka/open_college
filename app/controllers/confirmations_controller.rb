class ConfirmationsController < ApplicationController

  def new
    
  end

  def edit
    @user = User.find_by_confirmation_token!(params[:id])
    @user.university_id = 1
    @user.school_year = 1
    @user.save
  end

  def create
    current_user.university_email = params[:email]
    if current_user.save
      current_user.send_confirmation
      flash[:success] = "Email sent with confirmation instructions."
      redirect_to send_mail_confirmation_url(current_user.id)
    else
      flash.now[:error] = 'Invalid email format'
      render 'new'
    end
  end

  def update
    @user = User.find_by_confirmation_token!(params[:id])
    if @user.confirmation_sent_at < 2.hours.ago
      flash.now[:error] = 'confirmation reset has expired.'
      redirect_to new_confirmation_path
    elsif @user.update_attributes(params[:user])
      flash[:success] = "confirmation has been reset!"
      redirect_to @user
    else
      render :edit
    end
  end

end