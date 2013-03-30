class ClassRoomForYearsController < ApplicationController

  def index
    render json: ClassRoomForYear.terms_for(params[:term])
  end

  def show
    @class_room_for_year = ClassRoomForYear.find(params[:id])
  end

end