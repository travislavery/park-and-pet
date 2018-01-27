class Park < ActiveRecord::Base
	has_many :pets
	belongs_to :owner
	include Slugify::InstanceMethods
  	extend Slugify::ClassMethods
  	extend NameSupplier

  	def pets_linked
  		self.pets.map do |pet|
  			"<a href='/pets/#{pet.slug}'> #{pet.name} </a>"
  		end
  	end
end