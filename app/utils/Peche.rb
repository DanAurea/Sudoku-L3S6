# => Author:: 		yguenver
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby

##
## Classe pour la technique 'Pêche à la ligne'.
##
class Peche < Technique

	##
	## Constructeur de la classe Peche
	##
	## @return     Une instance de la classe Peche
	##
	def Peche.creer()
		new()
	end
	
	##
	## Recherche une solution pour la technique utilisée
	##
	## @param 	grille 			La grille
	##
	## @return 	res, les informations pour aider l'utilisateur ou nil si la méthode ne trouve rien
	##
	def solution(grille)
	
		# res = Array.new()

		# [1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |numero|
		# 	listPresent = nombreDejaPresent(grille, numero)
			
		# 	x = 1
		# 	y = 1
			
		# 	listPresent.each{ |case,index|
		# 		if case.nil? then
					
		# 		end
		# 	}
		# }
	
		return nil
	end
end