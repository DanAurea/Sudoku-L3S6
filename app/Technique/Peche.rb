#Class Peche

class Peche << Technique{

	def Peche.creer()
		new()
	end
	

	def cherche(grille)
		res = Array.new()

		[1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |numero|
			listPresent = nombreDejaPresent(grille, numero)
			
			x = 1
			y = 1
			

			listPresent.each{ |case,index|
				if case.nil? then
					list = block(grille,index+1).select{|c| c.nil? && !estProtegee?(grille,c)}
					if list.length == 1 then
						return [,,]
					end
				end
			}
		}
		return false
	end
}
