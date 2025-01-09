class Transaction < ApplicationRecord
  belongs_to :category

  before_validation :assign_category, on: :create
  after_update :categorize_matches

  def uncategorized?
    category.name == "Uncategorized"
  end

  private

  def assign_category
    if matching_category.present?
      self.category = matching_category
    else
      self.category = Category.find_by(name: "Uncategorized")
    end
  end

  def categorize_matches
    matches = Transaction.where(description: description)
    matches.update_all(category_id: self.category.id)
  end

  def matching_category
    category = Transaction.where(description: description).where.not(category_id: 1).first&.category
    category.present? ? category : nil
  end
end
