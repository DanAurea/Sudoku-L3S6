# => Author:: 		yguenver
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby

##
## Classe TechniqueUsine permettant de 
##
class TechniqueUsine
	
	private_class_method new:

	## Création
	##
	## @return Une nouvelle instance de TechniqueUsine
	def TechniqueUsine.creer(tech)
		new(tech)
	end

	## Initialisation
	## 
	## @return Une nouvelle instance
	def initialize(tech)

		return Object.const_get(tech).new()
	end

end