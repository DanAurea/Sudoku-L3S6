# 	File description
# 	
# 	Author:: 		BastienMor
# 	Developers: 	BastienMor
# 	Version:: 		0.1
# 	Copyright:: 	© 2017
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class description
# 	Classe de test unitaire du générateur de grille.

require_relative '../../app/utils/Generateur'

##
## vérifie que chaque valeur soit correcte.
##
## @param grid la grille de sudoku
##
## @return true si les valeurs sont bonnes, false sinon.
##

def checkValues(grid)

	grid.each do |line|
		line.each do |value|
			if(value<1 || 9<value)
				return false
			end
		end
	end
	return true
end



##
## vérifie que chaque ligne soit correcte.
##
## @param grid la grille de sudoku
##
## @return true si la ligne est valide, false sinon.
##

def checkLine(grid)

	0.upto(8){ |x|
		if(grid[x].uniq().count() != 9)
			return false
		end
	}
	return true
end


##
## consulte une colone.
##
## @param grid la grille de sudoku et n le numéro de colone.
##
## @return une colone sous forme de list.
##

def gridCol(grid, n)

	col = Array.new()

	0.upto(8){ |x|
		col.push(grid[x][n])
	}
	return col
end


##
## vérifie que chaque colone soit correcte.
##
## @param grid la grille de sudoku
##
## @return true si la colone est valide, false sinon.
##

def checkCol(grid)

	0.upto(8){ |x|
		if(gridCol(grid, x).uniq().count() != 9)
			return false
		end
	}
	return true
end


##
## consulte un bloc de 3x3.
##
## @param grid la grille de sudoku et x,y les coordonées du bloc.
##
## @return un bloc sous forme de list.
##

def gridBloc(grid, x, y)
	bloc = Array.new()

	0.upto(2){ |i|
		0.upto(2){ |j|
			bloc.push(grid[3*x+i][3*y+j])
		}
	}
	return bloc
end


##
## vérifie que chaque bloc soit correcte.
##
## @param grid la grille de sudoku
##
## @return true si les blocs sont valide, false sinon.
##

def checkBloc(grid)

	0.upto(2){ |x|
		0.upto(2){ |y|
			if(gridBloc(grid, x, y).uniq().count() != 9)
				return false
			end
		}
	}
	return true
end


##
## vérifie que chaque valeur soit correcte.
##
## @param grid la grille de sudoku
##
## @return true si les valeurs sont valide, false sinon.
##

def checkAllVal(grid)

	grid.each do |l|
		l.each do |e|
			if (e == nil)
			else
				if (e>0) && (e<10)
				else
					return false
				end
			end
		end
	end
	return true
end


##
## vérifie que chaque valeur soit correcte après conversion de la grille.
##
## @param grid la grille de sudoku
##
## @return true si les valeurs sont valide, false sinon.
##

def checkAllValConverted(grid)

	grid.each do |l|
		l.each do |e|
			if (e['value'] == nil)
			else
				if (e['value']>0) && (e['value']<10)
				else
					return false
				end
			end
		end
	end
	return true
end



##
## méthode de test, génère une grille et test les lignes, colones et bloc de 9.
##
## @return true si la grille est valide, false sinon.
##

def grilleCorrecte()

	gen = Generateur.new(0)


	if(!checkValues(gen.grid))
		return false
	end

	if(!checkLine(gen.grid))
		return false
	end

	if(!checkCol(gen.grid))
		return false
	end

	if(!checkBloc(gen.grid))
		return false
	end

	if(!checkAllValConverted(gen.generer))
		return false
	end

	gen.convert()

	#if(!checkAllValConverted(gen.convert()))
	#	return false
	#end


	puts "All green."
	return true
end

