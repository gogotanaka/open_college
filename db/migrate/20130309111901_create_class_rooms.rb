class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.string :name
      t.string :term
      t.datetime :year

      t.timestamps
    end
  end
end
