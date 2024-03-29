class CreateJoinTableProductCategory < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :category_id
    create_join_table :products, :categories do |t|
      t.index [:product_id, :category_id]
      t.index [:category_id, :product_id]
    end
  end
end
