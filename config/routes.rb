Gsuggest::Application.routes.draw do
  root to: 'main#index'
  #match "/:q" => "main#search", as: :q, via: [:get]
  get "main/search", as: :q
end
