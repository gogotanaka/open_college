class AddUniversityIdToClassRoomForYears < ActiveRecord::Migration
  def change
    add_column :class_room_for_years, :university_id, :integer
    add_index  :class_room_for_years, :university_id
  end
end
