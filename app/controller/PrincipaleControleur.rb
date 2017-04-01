# => Controlleur vue principale
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class PrincipaleControleur
#
class PrincipaleControleur < Controller
	
	##
    ## Initialize
    ##
	def initialize ()
		#parametres fenetre
		@title = "Sudoku"
		@resizable = false
	end

	##
    ## Méthode à définir dans tout les cas !
    ##
    ## @return self
    ##
	def run()
		return self
	end
end
