class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      
      t.timestamps
    end
  end
end
