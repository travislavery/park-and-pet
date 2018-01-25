class Owner < ActiveRecord::Base
  has_many :pets
  has_many :parks
  has_secure_password
  validates_presence_of :username, :password
end