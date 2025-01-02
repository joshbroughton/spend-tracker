class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.date :date
      t.string :transaction_type
      t.string :description
      t.decimal :amount
      t.decimal :balance

      t.timestamps
    end
  end
end