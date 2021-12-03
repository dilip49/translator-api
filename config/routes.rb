Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :glossaries, only: %i[index create show] do
        resources :terms, only: %i[create]
      end
      resources :translations, only: %i[create show]
    end
  end
end
