class Pet < ActiveRecord::Base
	validates_presence_of :name, :color, :breed, :age
	belongs_to :owner
	belongs_to :park
	include Slugify::InstanceMethods
  	extend Slugify::ClassMethods
end