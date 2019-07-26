Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    devise_for :users
    root "static_pages#home"
    get "/search-users", to: "search_users#search_user_by_email"
    get "/get-user", to: "search_users#get_all_users"
    post "/add-friend", to: "contacts#create"
    post "/confirm-friend", to: "contacts#update"
    delete "/remove-friend", to: "contacts#destroy"
    get "/list-friend-request", to: "contacts#list_friend_request"
    get "/list-your-friend", to: "contacts#list_your_friend"
    get "/get-room-chat", to: "rooms#create"
  end
end
