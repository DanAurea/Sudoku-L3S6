# => Controlleur vue scores
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class ScoresControleur
#
class ScoresControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele utilisateur
		loadModel('Score')
		#parametres fenetre
		@title = "Sudoku - Scores"
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
		meilleursScores = @Score.meilleursScores(10)

		@content["meilleursScores"] = []

		meilleursScores.each do |score|
			@content["meilleursScores"] << [score["pseudo"], score["score"]]
		end
		
		return self
	end
end
