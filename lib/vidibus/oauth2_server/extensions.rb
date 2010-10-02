require "oauth2_server/extensions/controller"

ActiveSupport.on_load(:action_controller) do
  include Vidibus::Oauth2Server::Extensions::Controller
end
