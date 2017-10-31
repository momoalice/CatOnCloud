class CreateUserAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :user_auths do |t|
      t.string :name
      t.string :password
      t.integer :user_id

      t.timestamps
    end
  end
end
