#Class SCandidate

class SCandidate << Technique{

	def SCandidate.creer()
		new()
	end

	def cherche(grille)
		grilleIndice = indice(grille)

		[1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |numero|
			[1,2,3,4,5,6,7,8,9].each { |x|
				cpt=0
				[1,2,3,4,5,6,7,8,9].each { |y|
					if grilleIndice[x][y] then
						cpt +=1
					end
				}
				if cpt == 1 then return [x,y,numero] end
			}

			[1,2,3,4,5,6,7,8,9].each { |y|
				cpt=0
				[1,2,3,4,5,6,7,8,9].each { |x|
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

