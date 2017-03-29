#Class DSubset

class DSubset << Technique{

	def DSubset.creer()
		new()
	end

	def solution(grille)
		grilleIndice = indice(grille)

		[0,1,2,3,4,5,6,7,8].each { |x|
			col = colonne(grilleIndice,x)
			col.each{ |case,y|
				i = 0
				case.each_value(|v| if value then i+=1 end)

				res = Array.new()

				col[(y+1)..-1].each{ |casebis|
					if casebis == case then res << [x,y] end
				}
				if res.length == i then
					return res
				end
			}
		}

		[0,1,2,3,4,5,6,7,8].each { |y|
			lig = ligne(grilleIndice,y)
			lig.each{ |case,x|
				i = 0
				case.each_value(|v| if value then i+=1 end)

				res = Array.new()

				lig[(x+1)..-1].each{|casebis|
					if casebis == case then res << [x,y] end
				}
				if res.length == i then
					return res
				end
			}			
		}
		
		return false
	end
}