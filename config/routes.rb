Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  #root :to => redirect('https://github.com/johndavid400/oyb')
  root :to => 'home#today'

  get "get_passages" => "passages#get_passages"
  get "today" => "home#today"

  get 'oyb' => 'home#oyb'

end
