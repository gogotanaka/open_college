class SchoolSubject < ActiveRecord::Base
  attr_accessible :department_id, :name

  belongs_to :department
  has_many :users
end
