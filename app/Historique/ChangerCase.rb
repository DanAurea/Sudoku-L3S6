# => Author:: 		keryann
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby

##
## Classe ChangerCase permettant de faire ou de défaire les actions de l'utilisateur
##

class ChangerCase < Action
	##VI
	@valeur
	@ancienneValeur
	@case


	## Initialise
	##
	## @param 	cas 			Case à initialiser
	## @param 	entier			Valeur à affecter à la case
	## 
	def initialize(cas, entier)
		@case=cas
		@valeur=entier
		@ancienneValeur=nil
	end

	##
	## Change la valeur de la case
	##
	def faire()
		@ancienneValeur=@case.get
		@case.set(@valeur)

	end

	##
	## Défait le changement
	##
	def defaire()
		@ancienneValeur=@valeur
		@case.set(@ancienneValeur)
	end
end