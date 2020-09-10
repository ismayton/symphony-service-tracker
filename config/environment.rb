require 'bundler'

Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

configure :development do
  set :database, 'sqlite3:db/database.db'
end

require_all 'app'