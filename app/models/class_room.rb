class ClassRoom < ActiveRecord::Base
  attr_accessible :name, :term, :year

  has_many :relation_class_room_users
  has_many :users, through: :relation_class_room_users
  has_many :class_grades

  validates :name, presence: true
end