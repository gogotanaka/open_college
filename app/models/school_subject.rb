class SchoolSubject < ActiveRecord::Base
  attr_accessible :department_id, :name

  belongs_to :department
  has_many :users
  has_many :class_grades, through: :users, source: :class_grades

  def recommends
  	recommend = self.class_grades.select('class_room_id, 1.0 * sum(grade)/count(grade) gpa').group('class_room_id').to_a.select{|x| x.gpa.present? }.sort{|a, b| b.gpa <=> a.gpa}.map{|x|x.class_room_id}
    if recommend.length >10
      @rakutan, @egutan = recommend[0..4], recommend[recommend.length-5..recommend.length-1]
    else
      range = recommend.length/2 - 1
      @rakutan, @egutan = recommend[0..range], recommend[recommend.length-1-range..recommend.length-1]
    end
    return @rakutan, @egutan
  end
end
