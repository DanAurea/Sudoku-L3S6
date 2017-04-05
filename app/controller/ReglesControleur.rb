# => Controlleur vue regles
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class ReglesControleur
#
class ReglesControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele utilisateur
		loadModel("Utilisateur")
		#parametres fenetre
		@title = "Sudoku - Règles"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"
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
