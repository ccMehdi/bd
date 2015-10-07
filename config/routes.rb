Rails.application.routes.draw do

  root 'sessions#new'

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end


  resources :dashboards, only: [:index]
  resource :user_infos

  resources :get_file_providers, only: [:index]
  resources :get_file_details, only: [:show] do
    post :rename, to: 'get_file_details#rename', on: :collection
    post :create_folder, to: 'get_file_details#create_folder', on: :collection
  end

  resources :get_file_downloads, only: [:show]

end
