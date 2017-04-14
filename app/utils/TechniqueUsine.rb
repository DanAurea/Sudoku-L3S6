require_relative './Technique'
require_relative "./SCandidate.rb"
require_relative "./SCell.rb"
require_relative "./DSubset.rb"
require_relative "./Peche.rb"


##
## Classe pour l'usine à technique
##
class TechniqueUsine
	
	##
	## Une instance de la classe donnée en paramètre
	##
	## @param      tech 	Le nom de la technique
	##
	## @return     L'instance de la classe tech
	##
	def creer(tech)
		return Object.const_get(tech).new()
	end


end