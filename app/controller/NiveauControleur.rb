# => Controlleur vue choix des niveaux
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class NiveauControleur
#
class NiveauControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele utilisateur
		loadModel("Utilisateur")
		loadModel("Jeu")

		#parametres fenetre
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

		return self
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
