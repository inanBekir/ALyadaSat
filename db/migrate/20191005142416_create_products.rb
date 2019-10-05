class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :pname
      t.string :pdescription
      t.integer :pprice
      t.string :pimage
      t.string :plocation

      t.timestamps
    end
  end
end
