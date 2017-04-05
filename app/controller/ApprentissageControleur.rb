# => Controlleur vue apprentissage
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class ApprentissageControleur
#
class ApprentissageControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele grille
		loadModel("Grille")
		loadModel("Score")
		loadModel("Jeu")
		#parametres fenetre
		@title  = "Sudoku - Apprentissage"
		@content = {"grille" => nil}
	end

	def updateGrille(x, y, value)
		@grille[x][y]["value"] = value
		puts "updated"
	end

	##
	## Sauvegarde la partie dans un fichier yaml
	##
	## @return     Self
	##
	def sauvegarder()
		@Jeu.chrono = Header.temps
		@Jeu.score = Header.score
		@Jeu.grille = @content["grille"]

		## Sauvegarde la partie dans un fichier yaml au nom de l'utilisateur
		@Jeu.creerPartie (@content["pseudo"])

		return self
	end

	##
    ## Méthode à définir dans tout les cas !
    ##
    ## @return self
    ##
	def run()

		if(@content.has_key?(:niveau))
			niveau = @content[:niveau]
		else
			niveau = 1
		end

		@content["grille"] = @Grille.generer(niveau)
		
		return self
	end
end
