module NameSupplier
	def array_names
		self.all.map do |t|
			"<a href='/#{t.class.to_s.downcase.pluralize}/#{t.slug}'>#{t.name}</a>"
		end
	end
end