class ClassGradesController < ApplicationController

  def create
    @class_room = ClassRoom.find(params[:class_grade][:class_room_id])
    @grade = params[:class_grade][:grade]
    current_user.value!(@class_room, @grade)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
  end

end