class AdminController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :admin_user

  def control_panel
    
  end

  def user
  end

  def university
    @universities = University.order(:id).all
  end

  def new_school_subject
    @university = University.find(params[:university_id])
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.id == 1 || current_user.admin?
    end
end
