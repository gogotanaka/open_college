# coding: utf-8
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
    unless params[:email].blank?
      current_user.university_email = params[:email]
      if current_user.save
        current_user.send_confirmation
        flash[:success] = "入力いただいたメールアドレス宛に確認メールを送信しました。メールに書かれているリンクをクリックすると、オープンカレッジをご利用いただけます。"
        redirect_to send_mail_confirmation_url(current_user.id)
      else
        flash.now[:error] = 'メールアドレスのフォーマットが間違っています。'
        render 'new'
      end
    else
      flash.now[:error] = 'メールアドレスを入力してください。'
      render 'new'
    end
  end

  def update
    @user = User.find_by_confirmation_token!(params[:id])
    if @user.confirmation_sent_at < 2.hours.ago
      flash[:error] = 'confirmation has expired.'
      redirect_to new_confirmation_path
    elsif @user.update_attributes(params[:user])
      flash[:success] = "確認が終了いたしました。オープンカレッジをご利用いただけます。"
      redirect_to @user
    else
      render :edit
    end
  end

end