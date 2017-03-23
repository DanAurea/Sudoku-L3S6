#Class SCell

class SCell << Technique{

	def SCell.creer()
		new()
	end

	def cherche(grille)
		grilleIndice = indice(grille)
		
		[1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |b|
			blockIndice = block(grilleIndice,b)
			
			(-1).upto(1){ |x|
				(-1).upto(1){ |y|
					if blockIndice[x][y].count(true) == 1 then	
						blockIndice[x][y].each{ |bool,numero|
							if bool then return [(((b-1)*3)%9)+x,(b/3*3)+y,numero+1] end
						}
					end
				}
			}
		}
		return false
	end
}

