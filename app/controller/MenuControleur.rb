# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 
##	
## Classe permettant de créer un contrôleur pour la vue FenetreMenu
##
class MenuControleur < Controller

	##
    ## Initialize
    ##
	def initialize
		#charge le modèle utilisateur
		loadModel("Utilisateur")
		
		#paramètres fenêtre
		@title = "Sudoku - Menu"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"
	end

	##
	## Permet de connaître si une partie sauvegardée existe portant le nom du pseudo
	##
	## @param 	pseudo		Le pseudo de l'utilisateur
	##
	## @return 	boolean
	##
	def partieExiste(pseudo)
		return @Utilisateur.partieUtilisateur?(pseudo)
	end

	##
    ## Méthode à définir dans tous les cas !
    ##
    ## @return 	self
    ##
	def run
		return self
	end
end
