class AddConfirmationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :university_email, :string
    add_column :users, :confirmation_sent_at, :datetime
  end
end
