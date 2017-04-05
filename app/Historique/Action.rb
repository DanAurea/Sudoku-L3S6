# => Author:: 		keryann
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby

##
## Classe Action permettant de tester
##
class Action
	##VI
	@etiquette

	##
	## Initialise l'étiquette
	##
	## @param 	etiquette 		The etiquette
	##
	def initialize(etiquette)
		@etiquette=etiquette
	end

	##
	## Affiche l'étiquette
	##
	def faire()
		print @etiquette
	end

end