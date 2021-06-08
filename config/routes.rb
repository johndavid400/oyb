Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  #root :to => redirect('https://github.com/johndavid400/oyb')
  root :to => 'home#today'

  get 'dashboard' => 'dashboard#index'
  post 'dashboard' => 'dashboard#update'

  get "get_passages" => "passages#get_passages"
  get "today" => "home#today"

  namespace :api do
    namespace :v1 do
      get 'passages' => 'passages#get_passages'
    end
  end

  get 'oyb' => 'home#oyb'

end
