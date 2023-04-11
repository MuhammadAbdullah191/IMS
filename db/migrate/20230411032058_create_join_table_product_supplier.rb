class CreateJoinTableProductSupplier < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :supplier_id
    create_join_table :products, :suppliers do |t|
      t.index [:product_id, :supplier_id]
      t.index [:supplier_id, :product_id]
    end
  end
end
