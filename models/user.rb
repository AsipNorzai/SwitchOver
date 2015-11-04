# map class to the dishes table
class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
end
