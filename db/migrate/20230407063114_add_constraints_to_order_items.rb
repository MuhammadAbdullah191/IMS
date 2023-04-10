class AddConstraintsToOrderItems < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TRIGGER order_items_insert_price_constraint
      BEFORE INSERT ON order_items
      FOR EACH ROW
      WHEN NEW.price < -1
      BEGIN
        SELECT RAISE(ABORT, 'Price must be greater than -1');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER order_items_price_update_constraint
      BEFORE UPDATE ON order_items
      FOR EACH ROW
      WHEN NEW.price < -1
      BEGIN
        SELECT RAISE(ABORT, 'Price must be greater than or equal to -1');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER order_items_insert_quantity_constraint
      BEFORE INSERT ON order_items
      FOR EACH ROW
      WHEN NEW.quantity < -1
      BEGIN
        SELECT RAISE(ABORT, 'quantity must be greater than -1');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER order_items_quantity_update_constraint
      BEFORE UPDATE ON order_items
      FOR EACH ROW
      WHEN NEW.quantity < -1
      BEGIN
        SELECT RAISE(ABORT, 'quantity must be greater than or equal to -1');
      END;
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER order_items_insert_price_constraint;
    SQL
    execute <<-SQL
      DROP TRIGGER order_items_price_update_constraint;
    SQL
    execute <<-SQL
      DROP TRIGGER order_items_insert_quantity_constraint;
    SQL
    execute <<-SQL
      DROP TRIGGER order_items_quantity_update_constraint;
    SQL
  end
end
