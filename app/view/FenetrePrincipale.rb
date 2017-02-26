class FenetrePrincipale < View

	def test
		@content.each { |name, value| instance_variable_set("@" + name, value) }
	end

end