class AddUniversityIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :university_id, :integer
    add_column :users, :department_id, :integer
    add_column :users, :school_subject_id, :integer
    add_index  :users, :university_id
    add_index  :users, :department_id
    add_index  :users, :school_subject_id
  end
end
