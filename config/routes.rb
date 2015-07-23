Rails.application.routes.draw do
  root to: 'main#index'
  get 'main/search', as: :q
end
