class CreateRelationClassRoomUsers < ActiveRecord::Migration
  def change
    create_table :relation_class_room_users do |t|
      t.integer :user_id
      t.integer :class_room_id

      t.timestamps
    end
    add_index :relation_class_room_users, [:user_id, :class_room_id]
  end
end
