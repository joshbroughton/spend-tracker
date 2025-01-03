Rails.application.routes.draw do
  resources :categories

  get "transactions", to: "transactions#index", as: :transactions
  get "transactions/upload", to: "transactions#upload", as: :upload_transactions
  post "transactions/upload", to: "transactions#upload", as: :submit_transactions
  get "transactions/:id/change_category", to: "transactions#change_category", as: :change_transaction_category
  patch "transactions/:id/update_category", to: "transactions#update_category", as: :update_transaction_category
end
