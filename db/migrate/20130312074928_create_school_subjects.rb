class CreateSchoolSubjects < ActiveRecord::Migration
  def change
    create_table :school_subjects do |t|
      t.string :name
      t.integer :department_id

      t.timestamps
    end
  end
end
