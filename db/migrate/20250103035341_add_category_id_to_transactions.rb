class AddCategoryIdToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :category_id, :integer
  end
end
