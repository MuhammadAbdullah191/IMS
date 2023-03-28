class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ""
      t.integer :stock, null: false, default: 0
      t.text :description, null: false, default: ""
      t.integer :price, null: false, default: 0
      t.string :location_name, null: false, default: ""
      t.references :brand, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
