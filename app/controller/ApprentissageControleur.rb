require Core::ROOT + "utils/TechniqueUsine.rb"
# => Author:: 		Valentin, DanAurea
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby
# 	


##
## Classe permettant de créer un controlleur pour la vue FenetreApprentissage
##
class ApprentissageControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele grille
		loadModel("Grille")
		loadModel("Score")
		loadModel("Jeu")
		#paramètres fenêtre
		@title  = "Sudoku - Apprentissage"
		@content = {"grille" => nil}
	end

	##
	## Permet la mise à jour de la grille
	##
	## @param      x      Coordonnée x de la grille
	## @param      y      Coordonnée y de la grille
	## @param      value  La valeur pour la mise à jour
	##
	def updateGrille(x, y, value)
		@grille[x][y]["value"] = value
		puts "updated"
	end

	##
	## Sauvegarde la partie dans un fichier yaml
	##
	## @return 	self
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
    ## Méthode à définir dans tous les cas !
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
		@content["Techniques"] = TechniqueUsine.new()		


		return self
	end
end
