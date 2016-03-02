Rails.application.routes.draw do

  root :to => redirect('https://github.com/johndavid400/oyb')
  #root :to => 'home#today'

  get "get_passages" => "passages#get_passages"
  get "today" => "home#today"

end
