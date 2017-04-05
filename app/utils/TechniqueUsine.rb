require_relative './Technique'
require_relative "./SCandidate.rb"
require_relative "./SCell.rb"
require_relative "./DSubset.rb"
require_relative "./Peche.rb"

class TechniqueUsine
	
	def creer(tech)
		return Object.const_get(tech).new()
	end

	def initialize()
	end

end