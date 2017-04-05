# 	Author:: 		BastienMor
# 	Developers: 	BastienMor
# 	Version:: 		0.1
# 	Copyright:: 	© 2017
# 	License::   	Distributes under the same terms as Ruby
# 	
 	

# gen = Generateur.new()
# g1 = gen.generer(1)
# g2 = gen.generer(1)

##
## 	Génération de grille de Sudoku (création de difficulté).
##
class Generateur

	@grid
	@difficulte

	attr_reader :grid, :difficulte

	##
	## Initialisation
	## 
	## @param difficulte	Difficulté à prendre en compte
	##

	def initialize(difficulte)
		@grid = Array.new()
		ligne = Array.new()

		@difficulte = difficulte

		9.times do
			val = 1+rand(9)
			while(ligne.include? val)
				val = 1+rand(9)
			end
			ligne.unshift(val)
		end

		3.times do
			3.times do
				@grid.push(ligne.clone)
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

			switchrow(a, b)
			switchcol(a, b)
			switchrow(5-a, 5-b)
			switchcol(8-a, 8-b)
		end

		complexifier()
	end


	##
	## Génère une grille avec une difficulté variable
	##
	## @param      d   Niveau de difficulté (1,2,3 pour respectivement facile, moyen, difficile)
	##
	def generer()
		self.convert()
	end

	##
	## Echange la place de 2 lignes.
	##
	def switchrow(a, b)
		@grid[a], @grid[b] = @grid[b], @grid[a]
	end

	##
	## Ehange la place de 2 colones.
	##

	def switchcol(a, b)
		@grid.map {|e| e[a], e[b] = e[b], e[a]}
	end


	##
	## Retire des cases pour créer la difficulté.
	##
	## @param d la difficulté souhaitée.
	##
	## @return la grille
	def complexifier()

		present = Array.new
		9.times do
			val = 1+rand(9)
			while(present.include? val)
				val = 1+rand(9)
			end
			present.unshift(val)
		end

		1.upto(@difficulte) do
			victime = present.pop()
			@grid.each do |a|
				a.each_with_index do |c, index|
					if c == victime
						a[index] = nil
					end
				end
			end
		end


		nbkill = 0
		@grid.each do |a|
			nbkill += a.count(nil)
		end
		nbkill = (81-nbkill)* @difficulte *0.1

		0.upto(nbkill) do
			x = rand(9)
			y = rand(9)
			while(@grid[x][y] == nil)
				x = rand(9)
				y = rand(9)
			end
			@grid[x][y] = nil
		end

		return @grid
	end


	##
	## Convertit la grille de list{ list{int}} -> list{ list{ hash[value, unique]}}.
	##
	## @return la grille convertie.
	##
	def convert()

		res = Array.new()
		ligne = Array.new()

		@grid.each do |line|
			line.each do |elem|
				val = Hash.new()
				val["value"] = elem
				val["editable"] = false
				
				if(elem == nil)
					val["editable"] = true
				end

				ligne.push(val.clone())
			end
			res.push(ligne.clone())
			ligne = Array.new()
		end

		return res
	end
end

