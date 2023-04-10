class AddConstraintsToSuppliers < ActiveRecord::Migration[6.0]
  def up

    execute <<-SQL
      CREATE TRIGGER suppliers_insert_name_constraint
      BEFORE INSERT ON suppliers
      FOR EACH ROW
      WHEN (LENGTH(NEW.name) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Name must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER suppliers_update_name_constraint
      BEFORE UPDATE ON suppliers
      FOR EACH ROW
      WHEN (LENGTH(NEW.name) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Name must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER suppliers_insert_address_constraint
      BEFORE INSERT ON suppliers
      FOR EACH ROW
      WHEN (LENGTH(NEW.address) > 50)
      BEGIN
        SELECT RAISE(ABORT, 'address must be 50 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER suppliers_update_address_constraint
      BEFORE UPDATE ON suppliers
      FOR EACH ROW
      WHEN (LENGTH(NEW.address) > 50)
      BEGIN
        SELECT RAISE(ABORT, 'address must be 50 characters or less');
      END;
    SQL

    add_index :suppliers, :email, unique: true
  end

  def down
    execute <<-SQL
      DROP TRIGGER suppliers_insert_name_constraint
    SQL
    execute <<-SQL
      DROP TRIGGER suppliers_update_name_constraint
    SQL
    
    execute <<-SQL
    DROP TRIGGER suppliers_insert_address_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER suppliers_update_address_constraint
    SQL

    remove_index :suppliers, :email

  end
end
