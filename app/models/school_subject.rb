class SchoolSubject < ActiveRecord::Base
  attr_accessible :department_id, :name

  belongs_to :department
  has_many :users
  has_many :class_grades, through: :users, source: :class_grades

end
