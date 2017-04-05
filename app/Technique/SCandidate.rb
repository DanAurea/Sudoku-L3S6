# => Author:: 		yguenver
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby

##
## Classe pour la technique 'Single Candidate'.
##
class SCandidate < Technique

	##
	## Constructeur de la classe SCandidate
	##
	## @return 	Une instance de la classe SCandidate
	##
	def SCandidate.creer()
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
		grilleIndice = indice(grille)

		[1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |numero|
			grilleIndice.sort_by{rand}.each_index { |x|
				cpt=0
				ytmp=0
				grilleIndice[x].sort_by{rand}.each_index { |y|
					if grilleIndice[x][y][numero.to_s] then
						cpt +=1
						ytmp = y
					end
				}
				if cpt == 1 then return [x,ytmp,numero.to_s] end
			}

			[0,1,2,3,4,5,6,7,8].sort_by{rand}.each { |y|
				cpt=0
				xtmp=0
				[0,1,2,3,4,5,6,7,8].sort_by{rand}.each { |x|
					if grilleIndice[x][y][numero.to_s] then
						cpt +=1
						xtmp = x
					end
				}
				if cpt == 1 then return [xtmp,y,numero.to_s] end
			}
		}

		return nil
	end
end