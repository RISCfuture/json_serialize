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
  gem.name        = 'json_serialize'
  gem.summary     = %Q{Adds JSON serialization to ActiveRecord models}
  gem.description = %Q{Adds to ActiveRecord the ability to JSON-serialize certain fields.}
  gem.email       = 'git@timothymorgan.info'
  gem.homepage    = 'http://github.com/riscfuture/json_serialize'
  gem.authors     = ['Tim Morgan']
  gem.files       = %w( lib/**/* json_serialize.gemspec LICENSE README.md )
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'yard'

# bring sexy back (sexy == tables)
module YARD::Templates::Helpers::HtmlHelper
  def html_markup_markdown(text)
    markup_class(:markdown).new(text, :gh_blockcode, :fenced_code, :autolink, :tables, :no_intraemphasis).to_html
  end
end

YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << '-m' << 'markdown'
  doc.options << '-M' << 'redcarpet'
  doc.options << '--protected' << '--no-private'
  doc.options << '-r' << 'README.md'
  doc.options << '-o' << 'doc'
  doc.options << '--title' << 'json_serialize Documentation'

  doc.files = %w(lib/**/* README.md)
end

task(default: :spec)
