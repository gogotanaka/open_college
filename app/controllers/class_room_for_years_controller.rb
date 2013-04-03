class ClassRoomForYearsController < ApplicationController

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

end