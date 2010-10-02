require "rubygems"
require "rake"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "vidibus-oauth2_server"
    gem.summary = %Q{OAuth2 server for Rails 3 with Mongoid.}
    gem.description = %Q{OAuth2 server for Rails 3 with Mongoid.}
    gem.email = "andre@vidibus.com"
    gem.homepage = "http://github.com/vidibus/vidibus-oauth2_server"
    gem.authors = ["Andre Pankratz"]
    gem.add_dependency "rails", "~> 3.0.0"
    gem.add_dependency "mongoid", "~> 2.0.0.beta.20"
    gem.add_dependency "vidibus-core_extensions"
    gem.add_dependency "vidibus-uuid"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
