Gsuggest::Application.routes.draw do
  root to: 'main#index'
  get 'main/search', as: :q
end
