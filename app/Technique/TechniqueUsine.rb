#Class TechniqueUsine

class TechniqueUsine{
	
	private_class_method new:

	def TechniqueUsine.creer(tech)
		new(tech)
	end

	def initialize(tech)

		return new Object.const_get(tech)
	end

}

