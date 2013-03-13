class CreateClassRoomForYears < ActiveRecord::Migration
  def change
    create_table :class_room_for_years do |t|
      t.string :name
      t.string :teacher_name

      t.timestamps
    end
    add_index :class_room_for_years, [:name]
  end
end
