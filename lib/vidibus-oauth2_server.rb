require "vidibus-core_extensions"

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib", "vidibus"))
require "oauth2_server"
require "oauth2_server/extensions"

module Vidibus::Oauth2Server
  class Engine < ::Rails::Engine; end
end
