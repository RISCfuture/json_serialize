Bundler.require :default, :test

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'json_serialize'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'test.sqlite'
)

$default = "default value"
class Json < ActiveRecord::Base
  include JsonSerialize
  json_serialize :data, default: $default, default_proc: -> { Hash.new }
end

RSpec.configure do |config|
  config.before(:each) do
    Json.connection.execute "DROP TABLE IF EXISTS jsons"
    Json.connection.execute "CREATE TABLE jsons (id INTEGER PRIMARY KEY ASC, data TEXT, 'default' TEXT, default_proc TEXT)"
  end
end
