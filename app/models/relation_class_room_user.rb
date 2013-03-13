class RelationClassRoomUser < ActiveRecord::Base
  attr_accessible :class_room_id, :user_id

  belongs_to :class_room
  belongs_to :user

  
end
