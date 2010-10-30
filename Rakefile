require 'rake'
begin
  require 'bundler'
rescue LoadError
  puts "Bundler is not installed; install with `gem install bundler`."
  exit 1
end

Bundler.require :default

Jeweler::Tasks.new do |gem|
  gem.name = "json_serialize"
  gem.summary = %Q{Adds JSON serialization to ActiveRecord models}
  gem.description = %Q{Adds to ActiveRecord the ability to JSON-serialize certain fields.}
  gem.email = "git@timothymorgan.info"
  gem.homepage = "http://github.com/riscfuture/json_serialize"
  gem.authors = [ "Tim Morgan" ]
  gem.required_ruby_version = '>= 1.9'
  gem.add_dependency "activesupport", ">= 2.0"
end
Jeweler::GemcutterTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << "-m" << "textile"
  doc.options << "--protected"
  doc.options << "-r" << "README.textile"
  doc.options << "-o" << "doc"
  doc.options << "--title" << "json_serialize Documentation".inspect
  
  doc.files = [ 'lib/**/*', 'README.textile' ]
end

task(default: :spec)
