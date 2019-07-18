Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root "static_pages#home"
    get "/search-users", to: "search_users#search_user_by_email"
    get "/get-user", to: "search_users#get_all_users"
  end
end
