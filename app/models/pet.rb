class Pet < ActiveRecord::Base
	validates_presence_of :name, :color, :breed, :age
	belongs_to :owner
	belongs_to :park
  has_many :comments
	include Slugify::InstanceMethods
	extend Slugify::ClassMethods
  extend NameSupplier

  def self.adoptables
    Pet.all.select do |pet|
      pet.adoptable
    end
  end
end