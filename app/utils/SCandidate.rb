
##
## Classe pour single candidate.
##
class SCandidate < Technique

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
			grilleIndice.sort_by{rand}.each_with_index { |col,x|
				cpt=0
				ytmp=0
					col.sort_by{rand}.each_with_index { |c,y|
						if c[numero.to_s] then
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

	##
	## Retourne le nombre d'étape pour faire la technique
	##
	## @return     Le nombre d'étape(s)
	##
	def combienEtape()
		return 2
	end

	##
	## Retourne les étapes pour faire la technique
	##
	## @param      n     Le numéro de la technique
	##
	## @return     Un text expliquant l'étape sinon
	##
	def etape(n)

		case(n)
		when 1
			return "Bienvenue sur l'explication de la technique "+self.class.to_s+"."
		when 2
			return "Recherchez les candidats possibles pour chaque case d'une ligne/colonne. Remarquez que dans certaines, un candidat n'est possible que dans une seule case de la ligne/colonne."
		end
		
		return nil
	end
end