

class ChangerCase < Action
	@valeur
	@ancienneValeur
	@case

	def initialize(case,entier)
		@case=case
		@valeur=entier
		@ancienneValeur=nil
	end

	def faire()
		@ancienneValeur=@case.get
		@case.set(@valeur)

	end

	def defaire()
		@ancienneValeur=@valeur
		@case.set(@ancienneValeur)
	end

end