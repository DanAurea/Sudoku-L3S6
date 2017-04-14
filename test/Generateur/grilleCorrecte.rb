require_relative '../../app/utils/Generateur'

# 	Author:: 		BastienMor
# 	Developers: 	BastienMor
# 	Version:: 		0.1
# 	Copyright:: 	© 2017
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
##
## Classe de test unitaire du générateur de grille.
##


##
## Vérifie que chaque valeur est correcte
##
## @param 	grid 		La grille du sudoku
##
## @return 	true si les valeurs sont bonnes, false sinon.
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
## Vérifie que chaque ligne est correcte
##
## @param 	grid 	La grille du sudoku
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
## Consulte une colonne
##
## @param 	grid 	La grille de sudoku
## @param 	n 		Le numéro de colonne
##
## @return une colonne sous forme d'une liste.
##
def gridCol(grid, n)

	col = Array.new()

	0.upto(8){ |x|
		col.push(grid[x][n])
	}
	return col
end


##
## Vérifie que chaque colone est correcte
##
## @param grid la grille de sudoku
##
## @return true si la colonne est valide, false sinon.
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
## Consulte un bloc de 3x3 (=région)
##
## @param 	grid 	La grille de sudoku 
## @param 	x 		Coordonnée x du bloc
## @param 	y 		Coordonnée y du bloc
##
## @return un bloc sous forme d'une liste.
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
## Vérifie que chaque bloc est correcte.
##
## @param grid la grille de sudoku
##
## @return true si les blocs sont valides, false sinon.
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
## vérifie que chaque valeur est correcte.
##
## @param grid la grille de sudoku
##
## @return true si les valeurs sont valides, false sinon.
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
## Vérifie que chaque valeur est correcte après conversion de la grille.
##
## @param 	grid 	La grille de sudoku
##
## @return true si les valeurs sont valides, false sinon.
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
## Méthode de test, génère une grille et teste les lignes, colonnes et régions.
##
## @return true si la grille est valide, false sinon.
##
def grilleCorrecte()

	gen = Generateur.new(0)

	if(!checkAllValConverted(gen.generer()))
		return false
	end


	puts "All green."
	return true
end

