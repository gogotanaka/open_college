# coding: utf-8
class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :first_name, :last_name, :name, :password, :password_confirmation, :school_year, :play, :university_id, :department_id, :school_subject_id

  belongs_to :university
  belongs_to :department
  belongs_to :school_subject
  has_many :class_rooms, through: :class_grades
  has_many :class_grades
  before_save { |user| user.email = email.downcase }
  before_create :create_remember_token
  before_create :generate_access_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  VALID_UNIVERSITY_EMAIL_REGEX = /\A[\w+\-.]+@(a|z)[0-9]\.keio\.jp\z/i
  validates :university_email, allow_blank: true, format: { with: VALID_UNIVERSITY_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  def value?(class_room)
    class_grades.find_by_class_room_id(class_room.id)
  end

  def value!(class_room, grade)
    case grade
    when "Ａ"
      value = 4
    when "Ｂ"
      value = 3
    when "Ｃ"
      value = 2
    when "Ｄ"
      value = 0
    else
    end
    class_grades.create!(class_room_id: class_room.id, grade: value)
  end

  def calculate
    gpa = self.class_grades.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a[0].gpa
    sprintf( "%.2f", gpa )
  end

  def recommend_difficult_class
    one_more_grade_users = User.joins(:department).where(departments: {id: self.department.id}).where(school_year: self.school_year + 1)
  end
  
  def recommends
    user = User.where('school_year = ? AND school_subject_id = ?', self.school_year + 1, self.school_subject_id).first
    if user
      recommend = user.class_rooms.where('year = 2012').joins(:class_grades).select('class_grades.class_room_id, 1.0 * sum(class_grades.grade)/count(class_grades.grade) gpa').group('class_grades.class_room_id').to_a.select{|x| x.gpa.present? }.sort{|a, b| b.gpa <=> a.gpa}.map{|x|x.class_room_id}
      if recommend.length >12
        @rakutan, @egutan = recommend[0..5], recommend.reverse[0..5]
      else
        range = recommend.length/2 - 1
        @rakutan, @egutan = recommend[0..range], recommend.reverse[0..range]
      end
    else
      @rakutan, @egutan = [],[]
    end
    return @rakutan, @egutan
  end

  def fourth_student_recommends
    user = User.where('school_subject_id = ?', self.school_subject_id).first
    if user
      recommend = user.class_rooms.where('year = 2012').joins(:class_grades).select('class_grades.class_room_id, 1.0 * sum(class_grades.grade)/count(class_grades.grade) gpa').group('class_grades.class_room_id').to_a.select{|x| x.gpa.present? }.sort{|a, b| b.gpa <=> a.gpa}.map{|x|x.class_room_id}
      if recommend.length >12
        @rakutan, @egutan = recommend[0..5], recommend.reverse[0..5]
      else
        range = recommend.length/2 - 1
        @rakutan, @egutan = recommend[0..range], recommend.reverse[0..range]
      end
    else
      @rakutan, @egutan = [],[]
    end
    return @rakutan, @egutan
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def send_confirmation
    generate_token(:confirmation_token)
    self.confirmation_sent_at = Time.zone.now
    save!
    UserMailer.confirmation(self).deliver
  end

  private

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def generate_access_token
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists?(access_token: access_token)
    end

end
