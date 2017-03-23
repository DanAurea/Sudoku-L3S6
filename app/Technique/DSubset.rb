#Class DSubset

class DSubset << Technique{

	def DSubset.creer()
		new()
	end

	def cherche(grille)
		grilleIndice = indice(grille)

		[1,2,3,4,5,6,7,8,9].each { |x|
			col = colonne(grilleIndice,x)
			col.each{ |case,y|
				i = case.count(true)
				cpt = Array.new()

				col[y..-1].each{|casebis|
					if casebis == case then cpt << [x-1,y] end
				}
				if cpt.length == i then
					return cpt
				end
			}			
		}

		[1,2,3,4,5,6,7,8,9].each { |y|
			lig = ligne(grilleIndice,y)
			lig.each{ |case,x|
				i = case.count(true)
				cpt = Array.new()

				lig[y..-1].each{|casebis|
					if casebis == case then cpt << [x,y-1] end
				}
				if cpt.length == i then
					return cpt
				end
			}			
		}
		
		return false
	end
}