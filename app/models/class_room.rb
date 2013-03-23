# coding: utf-8
class ClassRoom < ActiveRecord::Base
  attr_accessible :term, :year, :class_room_for_year_id

  belongs_to :class_room_for_year
  has_many :relation_class_room_users
  has_many :users, through: :relation_class_room_users
  has_many :class_grades
  def get_grade(user)
  	grade = ClassGrade.find_by_class_room_id_and_user_id(self.id, user.id).grade
  	case grade
    when 4
      'A'
    when 3
      'B'
    when 2
      'C'
    when 1
      'D'
    else
    	"放棄"
    end
  end
end