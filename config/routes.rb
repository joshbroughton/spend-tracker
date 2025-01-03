Rails.application.routes.draw do
  resources :categories

  get "transactions", to: "transactions#index", as: :transactions
  get "transactions/upload", to: "transactions#upload", as: :upload_transactions
  post "transactions/upload", to: "transactions#upload", as: :submit_transactions
  get "up" => "rails/health#show", as: :rails_health_check
end
