class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :consumer_name, null: false, default: ""

      t.timestamps
    end
  end
end
