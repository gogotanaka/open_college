class AddClassRoomForYearsId < ActiveRecord::Migration
  def change
    add_column :class_rooms, :class_room_for_year_id, :integer
    add_index  :class_rooms, :class_room_for_year_id
  end
end
