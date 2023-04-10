class AddConstraintsToProducts < ActiveRecord::Migration[6.0]

  def up
    execute <<-SQL
      CREATE TRIGGER products_insert_name_constraint
      BEFORE INSERT ON products
      FOR EACH ROW
      WHEN (LENGTH(NEW.name) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Name must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_update_name_constraint
      BEFORE UPDATE ON products
      FOR EACH ROW
      WHEN (LENGTH(NEW.name) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Name must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_insert_description_constraint
      BEFORE INSERT ON products
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 50)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 50 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_update_description_constraint
      BEFORE UPDATE ON products
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 50)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 50 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_insert_price_constraint
      BEFORE INSERT ON products
      FOR EACH ROW
      WHEN NEW.price < 1
      BEGIN
        SELECT RAISE(ABORT, 'Price must be greater than 0');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_price_update_constraint
      BEFORE UPDATE ON products
      FOR EACH ROW
      WHEN NEW.price < 1
      BEGIN
        SELECT RAISE(ABORT, 'Price must be greater than or equal to 0');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_insert_stock_constraint
      BEFORE INSERT ON products
      FOR EACH ROW
      WHEN NEW.stock < 0
      BEGIN
        SELECT RAISE(ABORT, 'stock must be greater or equal to zero');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER products_stock_update_constraint
      BEFORE UPDATE ON products
      FOR EACH ROW
      WHEN NEW.stock < 0
      BEGIN
        SELECT RAISE(ABORT, 'stock must be greater than or equal to 0');
      END;
    SQL

    add_index :products, :name, unique: true
  end
  
  def down
    execute <<-SQL
      DROP TRIGGER products_insert_name_constraint
    SQL
    execute <<-SQL
      DROP TRIGGER products_update_name_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER products_insert_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER products_update_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER products_insert_price_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER products_price_update_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER products_insert_stock_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER products_stock_update_constraint
    SQL

    remove_index :products, :name

  end

end
