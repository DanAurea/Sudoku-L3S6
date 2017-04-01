# => Controlleur vue reglages
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class ReglagesControleur
#
class ReglagesControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele utilisateur
		loadModel("Utilisateur")
		#parametres fenetre
		@title     = "Sudoku - Réglages"
		@width     = 600
		@height    = 550
		@resizable = false
		@position  = "CENTER_ALWAYS"
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
