class CreateClassGrades < ActiveRecord::Migration
  def change
    create_table :class_grades do |t|
      t.integer :user_id
      t.integer :class_room_id
      t.integer :grade

      t.timestamps
    end
    add_index :class_grades, [:user_id, :class_room_id]
  end
end
