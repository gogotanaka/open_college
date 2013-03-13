class ClassRoomForYear < ActiveRecord::Base
  attr_accessible :name, :teacher_name

  belongs_to :university
  has_many :class_rooms
end
