module ApplicationHelper
	def active?(path)
		#Este método regresa el string "active", que es 
		# lo que el tag de html necesita para funcionar
		"active" if current_page?(path)		
	end
end
