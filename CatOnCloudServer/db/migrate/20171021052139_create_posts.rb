class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.timestamp :time
      t.integer :likes
      t.text :imageURLS
      t.text :videoURLS
      t.integer :cat_id
      t.text :words
    end
  end
end
