class Owner < ActiveRecord::Base
  has_many :pets
  has_many :parks
  has_secure_password
  validates_presence_of :username, :password
  include Slugify::InstanceMethodsForOwner
  extend Slugify::ClassMethods

  def self.array_usernames
  	self.all.map do |owner|
		"<a href='/owners/#{owner.slug}'>#{owner.username}</a>"
	end
  end
end