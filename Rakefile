require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "json_serialize"
  gem.summary = %Q{Adds JSON serialization to ActiveRecord models}
  gem.description = %Q{Adds to ActiveRecord the ability to JSON-serialize certain fields.}
  gem.email = "git@timothymorgan.info"
  gem.homepage = "http://github.com/riscfuture/json_serialize"
  gem.authors = [ "Tim Morgan" ]
  gem.files = %w( lib/**/* json_serialize.gemspec LICENSE README.textile )
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'yard'
YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << "-m" << "textile"
  doc.options << "--protected"
  doc.options << "--no-private"
  doc.options << "-r" << "README.textile"
  doc.options << "-o" << "doc"
  doc.options << "--title" << "json_serialize Documentation"
  
  doc.files = [ 'lib/**/*', 'README.textile' ]
end

task(default: :spec)
