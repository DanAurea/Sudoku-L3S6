
##
## Classe pour disjoint subset.
##
class DSubset < Technique

	##
	## Constructeur de la classe DSubset
	##
	## @return     Une instance de la classe DSubset
	##
	def DSubset.creer()
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

		[0,1,2,3,4,5,6,7,8].each { |x|
			col = colonne(grilleIndice,x)
			col.each{ |c,y|
				i = 0
				c.each_value{|v| if v then i+=1 end }

				res = Array.new()

				col[(y+1)..-1].each{ |cBis|
					if cBis == c then res << [x,y] end
				}
				if res.length == i then
					return res
				end
			}
		}

		[0,1,2,3,4,5,6,7,8].each { |y|
			lig = ligne(grilleIndice,y)
			lig.each{ |c,x|
				i = 0
				c.each_value{|v| if v then i+=1 end }

				res = Array.new()

				lig[(x+1)..-1].each{|cBis|
					if cBis == c then res << [x,y] end
				}
				if res.length == i then
					return res
				end
			}			
		}
		
		return nil
	end

	##
	## Retourne le nombre d'étape pour faire la téchnique
	##
	## @return     Le nombre d'étape(s)
	##
	def combienEtape()
		return 3
	end

	##
	## Retourne les étapes pour faire la téchnique
	##
	## @param      n     Le numéro de la tachnique
	##
	## @return     Un text expliquant l'étape sinon
	##
	def etape(n)

		case(n)
		when 1
			return "Recherchez les candidats possibles pour chaque case d'une ligne/colonne."
		when 2
			return "Il arrive que N candicats soient possibles sur N cases d'une même ligne/colonne"
		when 3
			return "Dans ce cas, les N candidats sont applicable uniquement dans ces N cases et non ailleur."
		end
		
		return nil
	end

end
