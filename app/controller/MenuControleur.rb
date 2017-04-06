# => Controlleur vue menu
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class MenuControleur
#
class MenuControleur < Controller

	##
    ## Initialize
    ##
	def initialize
		#charge le modele utilisateur
		loadModel("Utilisateur")
		loadModel("Jeu")

		#parametres fenetre
		@title = "Sudoku - Menu"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"
	end


	##
	## Charge la dernière partie utilisateur
	##
	## @return     self
	##
	def charger
		Core::changeTo("JeuLibre", :pseudo => @content["pseudo"], :charger => true)
	end

	##
	## Permet de connaitre si une partie sauvegardée existe portant le nom du pseudo
	##
	## @param 	pseudo le pseudo de l'utilisateur
	##
	## @return 	boolean
	##
	def partieExiste(pseudo)
		return @Utilisateur.partieUtilisateur?(pseudo)
	end

	##
    ## Méthode à définir dans tout les cas !
    ##
    ## @return self
    ##
	def run
		return self
	end
end
