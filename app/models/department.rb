class Department < ActiveRecord::Base
  attr_accessible :name, :university_id

  belongs_to :university
  has_many :users
  has_many :class_grades, through: :users, source: :class_grades
  has_many :school_subjects

  def rank(school_year)
    user_ids = "SELECT a.id FROM users a WHERE a.school_year = :school_year"
    self.class_grades.select('user_id, 1.0 * sum(grade)/count(grade) gpa').where("user_id IN (#{user_ids})", school_year: school_year).group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}
  end
end
