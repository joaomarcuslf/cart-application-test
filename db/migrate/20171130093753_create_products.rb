class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 12, scale: 3

      t.timestamps
    end
  end
end
