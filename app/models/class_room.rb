class ClassRoom < ActiveRecord::Base
  attr_accessible :term, :year, :class_room_for_year_id

  belongs_to :class_room_for_year
  has_many :relation_class_room_users
  has_many :users, through: :relation_class_room_users
  has_many :class_grades

end