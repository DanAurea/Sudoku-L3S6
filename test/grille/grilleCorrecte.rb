

require_relative '../../app/utils/Generateur'

def checkLine(grid)

	0.upto(8){ |x|
		if(grid[x].uniq().count() != 9)
			return false
		end
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
			return false
		end
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
				return false
			end
		}
	}
	return true
end


def grilleCorrecte()

	gen = Generateur.new(0)

	if(!checkLine(gen.grid))
		return false
	end

	if(!checkCol(gen.grid))
		return false
	end

	gridBloc(gen.grid(), 0, 0)

	if(!checkBloc(gen.grid))
		return false
	end

	return true
end

grilleCorrecte()
