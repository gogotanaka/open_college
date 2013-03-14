class ClassRoomForYearsController < ApplicationController

  def show
    @class_room_for_year = ClassRoomForYear.find(params[:id])
  end

end