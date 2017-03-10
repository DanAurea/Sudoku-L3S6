
class SCandidate << Technique{

	def SCandidate.creer()
		new()
	end

	def cherche(grille)

		cpt=0
		[1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |numero|
			[1,2,3,4,5,6,7,8,9].each { |x|
				cpt=0
				colonne(grille,x).each{ |c|
					if c.liste_indice.hash[numero] == true then
						cpt +=1
					end
				}
				if cpt == 1 then return [] end
			}

			[1,2,3,4,5,6,7,8,9].each { |y|
				cpt=0
				ligne(grille,y).each{ |c|
					if c.liste_indice.hash[numero] == true then
						cpt +=1
					end
				}
				if cpt == 1 then return [] end
			}
		}

		return false
	end
}

ligne.(grille,)
