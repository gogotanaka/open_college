# coding: utf-8
class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :first_name, :last_name, :name, :password, :password_confirmation, :school_year, :play, :university_id, :department_id, :school_subject_id

  belongs_to :university
  belongs_to :department
  belongs_to :school_subject
  has_many :class_rooms, through: :class_grades, source: :class_room
  has_many :class_grades
  before_save { |user| user.email = email.downcase }
  before_create :create_remember_token
  before_create :generate_access_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

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

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def generate_access_token
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists?(access_token: access_token)
    end

end
