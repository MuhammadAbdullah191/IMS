class AddUsernameAndPhoneToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :username, :string, null: false
    add_column :admins, :phone, :string, null: false
  end
end
