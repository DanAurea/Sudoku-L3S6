# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
##
## Classe permettant de créer un contrôleur pour la vue FenetreScores
##
class ScoresControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modèle utilisateur
		loadModel('Score')
		#paramètres fenêtre
		@title = "Sudoku - Scores"
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
		meilleursScores = @Score.meilleursScores(10)

		@content["meilleursScores"] = []

		meilleursScores.each do |score|
			@content["meilleursScores"] << [score["pseudo"], score["score"]]
		end
		
		return self
	end
end
