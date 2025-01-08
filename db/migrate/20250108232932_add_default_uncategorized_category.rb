class AddDefaultUncategorizedCategory < ActiveRecord::Migration[8.0]
  def up
    Category.find_or_create_by(name: "Uncategorized")
  end

  def down
    # Optionally, you can remove this category if rolling back
    Category.where(name: "Uncategorized").delete_all
  end
end
