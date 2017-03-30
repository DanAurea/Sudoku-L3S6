
##
## Classe pour single candidate.
##
class SCandidate < Technique{

	##
	## Constructeur de la classe SCandidate
	##
	## @return     Une instance de la classe SCandidate
	##
	def SCandidate.creer()
		new()
	end

	##
	## Recherche une solution pour la technique utilisée
	##
	## @param      grille  La grille
	##
	## @return     Les informations pour aider l'utilisateur, ou nul si la méthode ne trouve rien
	##
	def solution(grille)
		grilleIndice = indice(grille)

		[1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |numero|
			grilleIndice.each { |col,x|
				cpt=0
				col.each { |c,y|
					if grilleIndice[x][y][numero.to_s] then
						cpt +=1
					end
				}
				if cpt == 1 then return [x,y,numero.to_s] end
			}

			[0,1,2,3,4,5,6,7,8].each { |y|
				cpt=0
				[0,1,2,3,4,5,6,7,8].each { |x|
					if grilleIndice[x][y][numero.to_s] then
						cpt +=1
					end
				}
				if cpt == 1 then return [x,y,numero.to_s] end
			}
		}

		return nil
	end
}

