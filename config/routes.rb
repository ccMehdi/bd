Rails.application.routes.draw do

  resources :sessions, only: [:new, :create] do
    # this will create for us a route with DELETE http verb and /sessions
    # adding the on: :collection option will make it part of the routes for
    # sessions which means it won't prepend the routes with /sessions/:session_id
    delete :destroy, on: :collection
  end

  resources :users

end
