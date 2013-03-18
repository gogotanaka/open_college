class AddTeacherIdToClassRoomForYear < ActiveRecord::Migration
  def change
    add_column :class_room_for_years, :teacher_id, :integer
    add_index  :class_room_for_years, :teacher_id
  end
end