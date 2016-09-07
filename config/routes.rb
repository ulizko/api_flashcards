ApiFlashcards::Engine.routes.draw do
  root 'main#main'
  namespace :api do
    namespace :v1 do
      resources :cards, only: [:create, :index, :show]
      put :review_card, to: 'trainer#review_card'
      get :trainer, to: 'trainer#index'
    end
  end
end
