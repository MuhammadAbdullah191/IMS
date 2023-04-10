class AddConstraintsToAdmins < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TRIGGER admins_insert_username_constraint
      BEFORE INSERT ON admins
      FOR EACH ROW
      WHEN (length(NEW.username) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Username must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER admins_update_username_constraint
      BEFORE UPDATE ON admins
      FOR EACH ROW
      WHEN (length(NEW.username) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Username must be 20 characters or less');
      END;
    SQL
    
    change_column :admins, :role, :integer, null: false, default: 1
    change_column :admins, :phone, :string, default: ''
  end

  def down
    change_column :admins, :phone, :string, default: nil
    change_column :admins, :role, :integer, default: nil
    execute <<-SQL
      DROP TRIGGER IF EXISTS admins_insert_username_constraint;
      DROP TRIGGER IF EXISTS admins_update_username_constraint;
    SQL
  end
  
end
