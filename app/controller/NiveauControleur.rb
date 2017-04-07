# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	

##	
## Classe permettant de créer un contrôleur pour la vue FenetreNiveau
##
class NiveauControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modèle utilisateur
		loadModel("Utilisateur")
		loadModel("Jeu")
		loadModel("Grille")

		#paramètres fenêtre
		@title = "Sudoku - Choix difficulté"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"
	end

	##
	## Supprime toute partie existante pour le joueur
	##
	## @param      pseudo  Pseudo utilisateur
	##
	## @return     self
	##
	def supprimerPartieExistante(pseudo)
		
		if(@Utilisateur.partieUtilisateur?(pseudo))
			@Jeu.supprimerPartie(pseudo)
		end
		@Grille.grille = nil

		return self
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
