class UpdateDescriptionAndAddressConstraint < ActiveRecord::Migration[6.0]
  def up
    # Drop existing triggers
    execute <<-SQL
      DROP TRIGGER IF EXISTS suppliers_insert_address_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS suppliers_update_address_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS products_insert_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS products_update_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS categories_insert_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS categories_update_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS brands_insert_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS brands_update_description_constraint
    SQL

    # Add new triggers with 200 character limit
    execute <<-SQL
      CREATE TRIGGER suppliers_insert_address_constraint
      BEFORE INSERT ON suppliers
      FOR EACH ROW
      WHEN (LENGTH(NEW.address) > 200)
      BEGIN
        SELECT RAISE(ABORT, 'address must be 200 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER suppliers_update_address_constraint
      BEFORE UPDATE ON suppliers
      FOR EACH ROW
      WHEN (LENGTH(NEW.address) > 200)
      BEGIN
        SELECT RAISE(ABORT, 'address must be 200 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_insert_description_constraint
      BEFORE INSERT ON products
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 200)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 200 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_update_description_constraint
      BEFORE UPDATE ON products
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 200)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 200 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER categories_insert_description_constraint
      BEFORE INSERT ON categories
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 200)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 200 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER categories_update_description_constraint
      BEFORE UPDATE ON categories
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 200)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 200 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER brands_insert_description_constraint
      BEFORE INSERT ON brands
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 200)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 200 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER brands_update_description_constraint
      BEFORE UPDATE ON brands
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 200)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 200 characters or less');
      END;
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS suppliers_insert_address_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS suppliers_update_address_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS products_insert_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS products_update_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS categories_insert_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS categories_update_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS brands_insert_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER IF EXISTS brands_update_description_constraint
    SQL
  end

end
