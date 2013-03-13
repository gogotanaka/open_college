class University < ActiveRecord::Base
  
  attr_accessible :name

  has_many :users
  has_many :class_room_for_years
  has_many :departments

end
