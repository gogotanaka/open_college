class ClassRoomForYear < ActiveRecord::Base
  attr_accessible :name, :teacher_id

  belongs_to :university
  belongs_to :teacher
  has_many :class_rooms

  def self.terms_for(prefix)
    class_rooms = where("name like ?", "#{prefix}_%")
    class_rooms.order(:name).map {|e| {id: e.id, label: e.name, value: e.name, teacher: e.teacher.name} } 
  end

end
