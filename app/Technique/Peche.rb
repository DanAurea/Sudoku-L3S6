
##
## @brief      Classe pour peche à la ligne.
##
class Peche < Technique{

	##
	## @brief      Constructeur de la classe Peche
	##
	## @return     Une instance de la classe Peche
	##
	def Peche.creer()
		new()
	end
	

	def solution(grille)
=begin
		res = Array.new()

		[1,2,3,4,5,6,7,8,9].sort_by{rand}.each { |numero|
			listPresent = nombreDejaPresent(grille, numero)
			
			x = 1
			y = 1
			
			listPresent.each{ |case,index|
				if case.nil? then
					
				end
			}
		}
=end
		return false
	end
}


