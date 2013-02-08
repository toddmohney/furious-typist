class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.boolean :is_email_validated
      t.string :first_name
      t.string :last_name
      t.boolean :is_enabled
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
