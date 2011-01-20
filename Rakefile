require "rubygems"
require "rake"
require "rake/rdoctask"
require "rspec"
require "rspec/core/rake_task"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "vidibus-oauth2_server"
    gem.summary = %Q{OAuth2 server for Rails 3 with Mongoid.}
    gem.description = %Q{OAuth2 server for Rails 3 with Mongoid.}
    gem.email = "andre@vidibus.com"
    gem.homepage = "http://github.com/vidibus/vidibus-oauth2_server"
    gem.authors = ["Andre Pankratz"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

Rspec::Core::RakeTask.new(:rcov) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rcov = true
  t.rcov_opts = ["--exclude", "^spec,/gems/"]
end

Rake::RDocTask.new do |rdoc|
  version = File.exist?("VERSION") ? File.read("VERSION") : ""
  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "vidibus-oauth2_server #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
  rdoc.options << "--charset=utf-8"
end
