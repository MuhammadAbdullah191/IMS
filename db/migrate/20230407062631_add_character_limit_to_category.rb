class AddCharacterLimitToCategory < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TRIGGER categories_insert_title_constraint
      BEFORE INSERT ON categories
      FOR EACH ROW
      WHEN (LENGTH(NEW.title) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Title must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER categories_update_title_constraint
      BEFORE UPDATE ON categories
      FOR EACH ROW
      WHEN (LENGTH(NEW.title) > 20)
      BEGIN
        SELECT RAISE(ABORT, 'Title must be 20 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER categories_insert_description_constraint
      BEFORE INSERT ON categories
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 50)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 50 characters or less');
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER categories_update_description_constraint
      BEFORE UPDATE ON categories
      FOR EACH ROW
      WHEN (LENGTH(NEW.description) > 50)
      BEGIN
        SELECT RAISE(ABORT, 'description must be 50 characters or less');
      END;
    SQL
    add_index :categories, :title, unique: true
  end

  def down
    execute <<-SQL
      DROP TRIGGER categories_insert_title_constraint
    SQL
    execute <<-SQL
      DROP TRIGGER categories_update_title_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER categories_insert_description_constraint
    SQL

    execute <<-SQL
      DROP TRIGGER categories_update_description_constraint
    SQL

    remove_index :categories, :title
  end
end
