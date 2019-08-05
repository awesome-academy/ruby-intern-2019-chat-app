Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    devise_for :users
    mount ActionCable.server => "/cable"

    root "static_pages#home"
    get "/search-users", to: "search_users#search_user_by_email"
    get "/get-user", to: "search_users#get_all_users"
    post "/add-friend", to: "contacts#create"
    post "/confirm-friend", to: "contacts#update"
    delete "/remove-friend", to: "contacts#destroy"
    get "/list-friend-request", to: "contacts#list_friend_request"
    get "/list-your-friend", to: "contacts#list_your_friend"
    get "/get-room-chat", to: "rooms#create"
    get "/get-message-room-chat", to: "messages#show"
    post "/new-chat", to: "messages#create"
    post "/upload-file-chat", to: "messages#upload_file"
    get "/list-file-room", to: "rooms#list_file_room"
    post "/create-group", to: "rooms#create_group"
    get "/add-friend-into-group", to: "search_users#search_by_email_in_list_friend"
    get "/open-modal-add-friend", to: "user_rooms#open_modal_add_friend"
    post "/add-user-to-group", to: "user_rooms#create"
    delete "/remove-user-in-group", to: "user_rooms#destroy"
    get "/list-member-in-group", to: "user_rooms#list_member_in_group"
    get "/change-status/:status", to: "users#change_status"
    get "/list-notification", to: "notifications#show"
  end
end
