class ClassRoomForYear < ActiveRecord::Base
  attr_accessible :name, :teacher_id

  belongs_to :university
  belongs_to :teacher
  has_many :class_rooms
end
