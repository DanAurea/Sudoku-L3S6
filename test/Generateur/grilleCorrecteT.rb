

require_relative '../../app/utils/Generateur'

def checkLine(grid)

	0.upto(8){ |x|
		if(grid[x].uniq().count() != 9)
			puts "# Ligne "+(x+1).to_s+" false."
			return false
		end
		puts "# Ligne "+(x+1).to_s+" true."
	}
	return true
end

def gridCol(grid, n)

	col = Array.new()

	0.upto(8){ |x|
		col.push(grid[x][n])
	}
	return col
end

def checkCol(grid)

	0.upto(8){ |x|
		if(gridCol(grid, x).uniq().count() != 9)
			puts "# Colone "+(x+1).to_s+" false."
			return false
		end
		puts "# Colone "+(x+1).to_s+" true."
	}
	return true
end

def gridBloc(grid, x, y)
	bloc = Array.new()

	0.upto(2){ |i|
		0.upto(2){ |j|
			bloc.push(grid[3*x+i][3*y+j])
		}
	}
	return bloc
end

def checkBloc(grid)

	0.upto(2){ |x|
		0.upto(2){ |y|
			if(gridBloc(grid, x, y).uniq().count() != 9)
				puts "# Bloc "+(x+1).to_s+"."+(y+1).to_s+" false."
				return false
			end
			puts "# Bloc "+(x+1).to_s+"."+(y+1).to_s+" true."
		}
	}
	return true
end


def grilleCorrecte()
	puts ""
	puts "####################################"
	puts "#### Test Generateur de grille. ####"
	puts "####################################"
	puts ""
	puts "## Affichage : "

	gen = Generateur.new(0)

	0.upto(8){ |x|
		puts gen.grid[x].to_s.gsub('nil', ' ')
	}
	puts ""
	puts ""
	puts "## Test des lignes : "
	if(!checkLine(gen.grid))
		return false
	end
	puts "\n### Fin test lignes ###"
	puts ""

	puts "## Test des colones : "
	if(!checkCol(gen.grid))
		return false
	end
	puts "\n### Fin test colones ###"
	puts ""



	gridBloc(gen.grid(), 0, 0)

	puts "## Test des blocs : "
	if(!checkBloc(gen.grid))
		return false
	end
	puts "\n### Fin test blocs ###"
	puts ""



	gen.complexifier(1)
	gen.convert()

	##puts gen.gridChecker(gr)


	puts "#### Fin des tests ####"
	return true
end

grilleCorrecte()
