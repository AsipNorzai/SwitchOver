require 'pry'
# require 'active_record'
# require 'sinatra'
# require 'sinatra/reloader'
# require 'pg' #to connect postgress

# show the sql in the terminal
ActiveRecord::Base.logger = Logger.new(STDERR)

require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/post'

binding.pry
