class ClassGrade < ActiveRecord::Base
  attr_accessible :class_room_id, :grade, :user_id

  belongs_to :user
  belongs_to :class_room

  
end
