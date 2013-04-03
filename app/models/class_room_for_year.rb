class ClassRoomForYear < ActiveRecord::Base
  attr_accessible :name, :teacher_id

  belongs_to :university
  belongs_to :teacher
  has_many :class_rooms
  has_many :class_grades, through: :class_rooms

  def self.terms_for(prefix)
    class_rooms = where("name like ?", "#{prefix}_%")
    class_rooms.order(:name).map {|e| {id: e.id, label: e.name, value: e.name, teacher: e.teacher.name} } 
  end

  def percents
  	denominator = self.class_grades.count
  	a = self.class_grades.where('grade = 4').count * 100 / denominator
  	b = self.class_grades.where('grade = 3').count * 100 / denominator
  	c = self.class_grades.where('grade = 2').count * 100 / denominator
  	d = 100 - a - b -c
  	return [a,b,c,d]
  end

end
