class CreateNewcats < ActiveRecord::Migration[5.1]
  def change
    create_table :newcats do |t|
      t.text :pics
      t.text :location
      t.string :name
      t.string :description
      t.integer :interested
      t.string :category

      t.timestamps
    end
  end
end
