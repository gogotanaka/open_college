class Department < ActiveRecord::Base
  attr_accessible :name, :university_id

  belongs_to :university
  has_many :users
  has_many :school_subjects
end
