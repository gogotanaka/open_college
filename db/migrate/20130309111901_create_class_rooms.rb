class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.string :term
      t.integer :year

      t.timestamps
    end
  end
end
