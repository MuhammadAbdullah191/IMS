class AddCharacterLimitToBrands < ActiveRecord::Migration[6.0]
  def up
    change_column :brands, :name, :string, limit: nil
    execute <<-SQL
      CREATE TRIGGER brands_insert_name_constraint
      BEFORE INSERT ON brands
      FOR EACH ROW
      WHEN (LENGTH(NEW.name) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Name must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER brands_update_name_constraint
      BEFORE UPDATE ON brands
      FOR EACH ROW
      WHEN (LENGTH(NEW.name) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Name must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER brands_insert_description_constraint
      BEFORE INSERT ON brands
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 50)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 50 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER brands_update_description_constraint
      BEFORE UPDATE ON brands
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 50)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 50 characters or less');
      END;
    SQL

    add_index :brands, :name, unique: true
  end

  def down
    execute <<-SQL
    DROP TRIGGER IF EXISTS brands_insert_name_constraint;
    DROP TRIGGER IF EXISTS brands_update_name_constraint;
    DROP TRIGGER IF EXISTS brands_insert_description_constraint;
    DROP TRIGGER IF EXISTS brands_update_description_constraint;
  SQL
    remove_index :brands, :name
  end
end