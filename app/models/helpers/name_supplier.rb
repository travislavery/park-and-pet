module NameSupplier
	def array_names
		self.all.map do |t|
			"<h3><a href='/#{t.class.to_s.downcase.pluralize}/#{t.slug}'>#{t.name}</a></h3>"
		end
	end
end