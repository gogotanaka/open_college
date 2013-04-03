class University < ActiveRecord::Base
  
  attr_accessible :name

  has_many :users
  has_many :class_room_for_years
  has_many :departments

  def rank(school_year)
    user_ids = "SELECT a.id FROM users a WHERE a.school_year = :school_year"
    ClassGrade.select('user_id, 1.0 * sum(grade)/count(grade) gpa').where("user_id IN (#{user_ids})", school_year: school_year).group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}
  end
end
