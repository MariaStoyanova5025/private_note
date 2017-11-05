Rails.application.routes.draw do
  resources :notes
  root 'application#home'
  post '/url' => 'notes#newNote'
  post '/messages/api' => 'notes#note_json'
  get '/show_note/:id' => 'notes#printNote'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
