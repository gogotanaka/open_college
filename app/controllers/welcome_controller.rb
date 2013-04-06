class WelcomeController < ApplicationController
  
  def index
    if current_user 
      redirect_to user_path(current_user)
      return 
    end
    @user = User.new
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  def grade_down
    user = User.find(59)
    user.school_year = 4
    user.save
  end
  
end
