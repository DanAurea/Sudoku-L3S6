#Class SCandidate

class SCandidate << Technique{

	def SCandidate.creer()
		new()
	end

	def cherche(grille)
		grilleIndice = indice(grille)

		[1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |numero|
			grilleIndice.each { |col,x|
				cpt=0
				col.each { |case,y|
					if grilleIndice[x][y] then
						cpt +=1
					end
				}
				if cpt == 1 then return [x,y,numero] end
			}

			[0,1,2,3,4,5,6,7,8].each { |y|
				cpt=0
				[0,1,2,3,4,5,6,7,8].each { |x|
					if grilleIndice[x][y] then
						cpt +=1
					end
				}
				if cpt == 1 then return [x,y,numero] end
			}
		}

		return false
	end
}

