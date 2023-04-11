class ChnageCategoryTitleToName < ActiveRecord::Migration[6.0]
  def up
    rename_column :categories, :title, :name
  end

  def down
    rename_column :categories, :name, :title
  end
end
