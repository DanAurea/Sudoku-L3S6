require_relative './Technique'

class TechniqueUsine
	
	private_class_method new:

	def TechniqueUsine.creer(tech)
		new(tech)
	end

	def initialize(tech)

		return Object.const_get(tech).new()
	end

end