
class Generateur

	def generer(d)
		grid = Array.new()
		ligne = Array.new()
	
		9.times do
			val = 1+rand(9)
			while(ligne.include? val)
				val = 1+rand(9)
			end
			ligne.unshift(val)
		end
		
		3.times do
			3.times do
				grid.push(ligne.clone)
				3.times do 
					ligne.unshift(ligne.pop())
				end
			end
			ligne.unshift(ligne.pop())
		end
		
		4.times do
			a = rand(3)
			b = rand(3)
			while(a == b)
				b = rand(3)
			end

			grid = switchrow(grid, a, b)
			grid = switchcol(grid, a, b)
			grid = switchrow(grid, 5-a, 5-b)
			grid = switchcol(grid, 8-a, 8-b)
		end
	
		return grid
	end
	
	def switchrow(grid, a, b)
		grid[a], grid[b] = grid[b], grid[a]
		return grid
	end
	
	def switchcol(grid, a, b)

		grid.map {|e| e[a], e[b] = e[b], e[a]}
		return grid
	end
	
	def complexifier(grid, d)
	
		present = Array.new
		9.times do
			val = 1+rand(9)
			while(present.include? val)
				val = 1+rand(9)
			end
			present.unshift(val)
		end

		1.upto(d) do
			victime = present.pop()
			grid.each do |a|
				a.each_with_index do |c, index|
					if c == victime
						a[index] = nil			
					end
				end			
			end
		end




			nbkill = 0
			grid.each do |a|
				nbkill += a.count(nil)
			end
			nbkill = (81-nbkill)*d*0.1
			
			0.upto(nbkill) do
				x = rand(9)
				y = rand(9)
				while(grid[x][y] == nil)
					x = rand(9)
					y = rand(9)
				end
				grid[x][y] = nil
			end
		return grid
	end


	def gridChecker(grid)

		0.upto(8){ |x|

			if(grid[x].uniq.size != 9)
				return false
			end
		}
		0.upto(8){ |x|

			if(gridCol(grid, x).uniq.size != 9)
				return false
			end
			return true
		}
	end

	def gridCol(grid, n)

		col = Array.new()

		0.upto(8){ |x|
			col.unshift(grid[n][x])
		}
		return col
	end

	
end
	
grid = Generateur.new()	

print grid.generer(1)