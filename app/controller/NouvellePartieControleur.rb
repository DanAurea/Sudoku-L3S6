# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
##
## Classe permettant de créer un contrôleur pour la vue FenetreNouvellePartie
##
class NouvellePartieControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modèle utilisateur
		loadModel("Utilisateur")
		#paramètres fenêtre
		@title = "Sudoku - Nouvelle Partie"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"
	end

	##
    ## Méthode à définir dans tous les cas !
    ##
    ## @return 	self
    ##
	def run()
		return self
	end
end
