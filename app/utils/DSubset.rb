
##
## Technique Disjoint Subset.
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
		
		res = Array.new()
		[0,1,2,3,4,5,6,7,8].each { |x|
			col = colonne(grilleIndice,x)
			col.each_with_index{ |c,y|
				i = 0
				c.each_value{|v| if v == true then i+=1 end }
				if i>1 then
					res << [x,y]
					col[(y+1)..(-1)].each_with_index{ |cBis,yBis|
						if cBis.eql?(c) then res << [x,y+yBis+1] end
					}
					if res.length == i then
						return res
					end
				end
				res = Array.new()
			}
		}
		
		[0,1,2,3,4,5,6,7,8].each { |y|
			lig = ligne(grilleIndice,y)
			lig.each_with_index{ |c,x|
				i = 0
				c.each_value{|v| if v == true  then i+=1 end }
				if i>1 then
					res << [x,y]
					lig[(x+1)..(-1)].each_with_index{|cBis,xBis|
						if cBis.eql?(c) then res << [x+xBis+1,y] end
					}
					if res.length == i then
						return res
					end
				end
				res = Array.new()
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
		return 4
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
			return "Recherchez les candidats possibles pour chaque case d'une ligne/colonne."
		when 3
			return "Il arrive que N candicats soient possibles sur N cases d'une même ligne/colonne"
		when 4
			return "Dans ce cas, les N candidats sont applicable uniquement dans ces N cases et non ailleur."
		end
		
		return nil
	end

end
