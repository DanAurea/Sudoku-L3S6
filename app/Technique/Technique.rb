

class Technique{
	
	private_class_method new:

	def Technique.creer()
		new()
	end


	def cherche(grille)
		return false
	end

	def indice(grille)
		grilleIndice = Array.new(9){Array.new(9){Array.new(9){false}}}

		[1,2,3,4,5,6,7,8,9].each { |x|
			[1,2,3,4,5,6,7,8,9].each { |y|
				if grille[x,y].nil? then
					[1,2,3,4,5,6,7,8,9].each { |numero|
						unless estProtegee(grille,numero.to_s,x,y) then grilleIndice[x-1][y-1] = true end
					}
				end
			}
		}

		return grilleIndice
	end
	
	def nombreDejaPresent(grille, numero)
		listPresent = Array.new(9) {}
		[1,4,7].each{ |x|
			[1,4,7].each{ |y|
				-1.upto(1){ |xbis|
					-1.upto(1){ |ybis|
						if numero == grille.laCase(x+xbis,y+ybis).valeur then
							listPresent[numero-1]=grille.laCase(x+xbis,y+ybis)
						end
					}
				}
			}
		}
		return listPresent
	end

	def block(grille, num)
		block = Array.new()
		
		x = ((num-1)*3)%9
		y = num/3*3

		block << grille[x..x+2][y..y+2]
	
		return block
	end

	def colonne(grille, num)
		return grille[num-1]
	end

	def ligne(grille, num)
		res = Array.new()
		grille.each{|c|
			res << c[num-1]
		}
		return res
	end

	def estProtegee?{grille, case, x, y}

		ligne = ligne(grille, y)
		colonne = colonne(grille, x)
		block = block(grille, )


		ligne.each{ |c|
			if case == c then
				return true
			end
		}
		colonne.each{ |c|
			if case == c then
				return true
			end
		}
		block.each{ |c|
			if case == c then
				return true
			end
		}

		return false
	end
}




