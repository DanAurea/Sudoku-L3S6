# => Controlleur vue apprentissage
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class ApprentissageControleur
#

require Core::ROOT + "utils/TechniqueUsine.rb"

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
		@content["Techniques"] = TechniqueUsine.new()		


		return self
	end
end
