class RelationClassRoomUsersController < ApplicationController

  def create
    @class_room = ClassRoom.find(params[:relation_class_room_user][:class_room_id])
    current_user.take!(@class_room)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

end
