class Teacher < ActiveRecord::Base
  attr_accessible :name
  has_many :class_room_for_years
end
