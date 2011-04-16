Rails.application.routes.draw do
  get "/oauth/authorize" => "oauth2/authentication#authorize"
  match "/oauth/access_token" => "oauth2/authentication#access_token", :via => [:get, :post]
  match "/oauth/oauth_token" => "oauth2/authentication#access_token", :via => [:get, :post]
  get "/oauth/user" => "oauth2/users#show"
end
