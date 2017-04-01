
##
## @brief      Classe action pour tester
##
class Action
	@etiquette
	def initialize(etiquette)
		@etiquette=etiquette
	end

	def faire()
		print @etiquette
	end

end