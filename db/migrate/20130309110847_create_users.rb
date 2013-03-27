class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :school_year
      t.string :play
      t.text :html, :limit => nil
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
