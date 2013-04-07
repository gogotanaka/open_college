class ClassRoomForYearsController < ApplicationController

  before_filter :signed_in_user

  def index
    render json: ClassRoomForYear.terms_for(params[:term])
  end

  def show
    @class_room_for_year = ClassRoomForYear.find(params[:id])
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    
end