Rails.application.routes.draw do
  get "/oauth/authorize" => "oauth2/authentication#authorize"
  post "/oauth/access_token" => "oauth2/authentication#access_token"
  get "/oauth/user" => "oauth2/users#show"
end
