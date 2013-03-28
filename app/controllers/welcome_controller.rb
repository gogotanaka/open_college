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

  def fix_gpa
    users = User.all
    users.each do |user|
      user.class_grades.each do |class_grade|
        if class_grade.grade == 1
          class_grade.grade = 0
        end
        class_grade.save
      end
    end
    redirect_to root_url
  end

end
