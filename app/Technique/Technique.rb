

class Technique{
	
	private_class_method new:

	def Technique.creer()
		new()
	end


	def solution(grille)
		return false
	end

	def indice(grille)
		grilleIndice = Array.new(9){Array.new(9){Hash.new()}}

		grille.each { |col,x|
			col.each { |case,y|
				if case.nil? then
					[1,2,3,4,5,6,7,8,9].each { |numero|
						unless estProtegee(grille,numero.to_s,x,y) then
							grilleIndice[x][y][numero.to_s] = true
						else
							grilleIndice[x][y][numero.to_s] = false
						end
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
		res = Array.new()
		
		x = ((num-1)*3)%9
		y = num/3*3

		grille[x..x+2].each{ |col|
			res << col[y..y+2]
		}

		return res
	end

	def colonne(grille, x)
		return grille[x]
	end

	def ligne(grille, y)
		res = Array.new()
		grille.each{ |col|
			res << col[y]
		}
		return res
	end

	def estProtegee?(grille, case, x, y)

		ligne = ligne(grille, y)
		colonne = colonne(grille, x)
		block = block(grille, aQuelBloc(x,y))


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
		block.each{ |col|
		 	col.each{ |c|
				if case == c then
					return true
				end
			}
		}

		return false
	end

	def aQuelBloc(x,y)
		return ((x/3)+1)+(y/3*3)
	end

}




