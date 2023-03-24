class AddRoleToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :role, :integer, null: false
  end
end
