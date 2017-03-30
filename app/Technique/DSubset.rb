
##
## @brief      Classe pour disjoint subset.
##
class DSubset < Technique{

	##
	## @brief      Constructeur de la classe DSubset
	##
	## @return     Une instance de la classe DSubset
	##
	def DSubset.creer()
		new()
	end

	##
	## @brief      Recherche une solution pour la technique utilisée
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
				c.each_value(|v| if value then i+=1 end)

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
				c.each_value(|v| if value then i+=1 end)

				res = Array.new()

				lig[(x+1)..-1].each{|cBis|
					if cBis == c then res << [x,y] end
				}
				if res.length == i then
					return res
				end
			}			
		}
		
		return false
	end
}