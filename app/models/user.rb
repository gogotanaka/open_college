class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :first_name, :last_name, :name, :password, :password_confirmation, :school_year, :university_id, :department_id, :school_subject_id

  belongs_to :university
  belongs_to :department
  belongs_to :school_subject
  has_many :relation_class_room_users
  has_many :class_rooms, through: :relation_class_room_users
  has_many :class_grades

  before_save { |user| user.email = email.downcase }
  before_create :create_remember_token
  before_create :generate_access_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def taking?(class_room)
    relation_class_room_users.find_by_class_room_id(class_room.id)
  end

  def take!(class_room)
    relation_class_room_users.create!(class_room_id: class_room.id)
  end

  def value?(class_room)
    class_grades.find_by_class_room_id(class_room.id)
  end

  def value!(class_room, grade)
    class_grades.create!(class_room_id: class_room.id, grade: grade)
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
