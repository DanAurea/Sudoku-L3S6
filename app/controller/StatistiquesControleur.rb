# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
	
 	
##
## Classe permettant de créer un contrôleur pour la vue FenetreStatistiques
##
class StatistiquesControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modèle utilisateur
		loadModel("Score")
		loadModel("Jeu")
		#paramètres fenêtre
		@title = "Sudoku - Statistiques"
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
		scores = @Score.scoreUtilisateur(@content["pseudo"])

		nombreParties = Array.new(3, 0)
		moyennes       = Array.new(3, 0)
		meilleursScores = Array.new(3, 0)

		## Calcule la moyenne des scores de l'utilisateur
		scores.each do |ligne|
			niveau = ligne["niveau"]
			score  = ligne["score"]

			moyennes[niveau]      += score
			nombreParties[niveau] += 1

			if(meilleursScores[niveau] < score)
				meilleursScores[niveau] = score
			end
		end

		(0...moyennes.length).each do |i|
			if(nombreParties[i] > 0)
				moyennes[i] /= nombreParties[i]
			end
		end

		@content["moyennes"]        = moyennes
		@content["meilleursScores"] = meilleursScores
		@content["nombreParties"]   = nombreParties

		return self
	end
end
