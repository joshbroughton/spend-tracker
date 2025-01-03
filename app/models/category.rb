class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :transactions, class_name: "Transaction", foreign_key: "category_id"
end
