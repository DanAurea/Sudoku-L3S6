
##
## Classe pour single cell.
##
class SCell < Technique{

	##
	## Constructeur de la classe SCell
	##
	## @return     Une instance de la classe SCell
	##
	def SCell.creer()
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
		
		[0,1,2,3,4,5,6,7,8].sort_by{rand}.each { |x|
			[0,1,2,3,4,5,6,7,8].sort_by{rand}.each { |y|
				cpt = 0
				grilleIndice[x][y].each_value(|v| if value then cpt+=1 end)
				if cpt == 1 then
					grilleIndice[x][y].each{ |key,value|
						if value then return [x,y,key] end
					}
				end
			}
		}
		return nil
	end
}

