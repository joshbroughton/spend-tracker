class Category < ApplicationRecord
  before_destroy :prevent_uncategorized_deletion
  validates :name, presence: true, uniqueness: true
  has_many :transactions, class_name: "Transaction", foreign_key: "category_id"

  private

  def prevent_uncategorized_deletion
    if name == "Uncategorized"
      errors.add(:base, "The 'Uncategorized' category cannot be deleted.")
      throw(:abort)
    end
  end
end
