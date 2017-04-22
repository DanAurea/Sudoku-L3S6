# => Author:: 		yguenver
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby


##
## Technique des jumeaux et triplés
##
class HPTriple < Technique

	##
	## Constructeur de la classe HPTriple
	##
	## @return une instance de la classe HPTriple
	##
	def HPTriple.creer
		new()
	end

	##
	## Recherche une solution pour la technique utilisée
	##
	## @param      grille  La grille
	##
	## @return     Les informations pour aider l'utilisateur, ou nil si la méthode ne trouve rien
	##
	def solution(grille)
		grilleIndice = indice(grille)

 		# res = Array.new()
		# [1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |b|
		#   [0,1,2,3,4,5,6,7,8].sort_by{rand}.each { |x|
		#     [1,2,3,4,5,6,7,8,9].sort_by{rand}.each{ |n|
		#       col = colonne(block(grilleIndice,b),x)
		#       col.each_with_index{ |hash,y| if hash[n.to_s] then res << [x,y] end}
		#     }
		#   }
		# }

		return nil
	end

	##
	## Retourne le nombre d'étape pour faire la technique
	##
	## @return     Le nombre d'étape(s)
	##
	def combienEtape()
		return 4
	end

	##
	## Retourne les étapes pour faire la technique
	##
	## @param      n     Le numéro de la technique
	##
	## @return     Un texte expliquant l'étape sinon nil
	##
	def etape(n)

		# case(n)
		# when 1
		# 	return "Bienvenue sur l'explication de la technique "+self.class.to_s+"."
		# when 2
		# 	return "Recherchez les candidats possibles pour chaque case d'une ligne/colonne."
		# when 3
		# 	return "Il arrive que N candicats soient possibles sur N cases d'une même ligne/colonne"
		# when 4
		# 	return "Dans ce cas, les N candidats sont applicable uniquement dans ces N cases et non ailleur."
		# end

		return nil
	end
end