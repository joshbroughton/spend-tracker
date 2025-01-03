module TransactionsHelper
  def toggle_direction(current_direction)
    current_direction == "asc" ? "desc" : "asc"
  end
end
