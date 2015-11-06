require 'active_record'

options = {
  adapter: 'postgresql',
  # username: 'asipnorzai' #I porobably don't need this
  database: 'switchover'
}

ActiveRecord::Base.establish_connection(options)
