Rails.application.routes.draw do
  match "oauth/authorize" => "oauth2#authorize", :via => :get
  match "oauth/access_token" => "oauth2#access_token", :via => :post
end
