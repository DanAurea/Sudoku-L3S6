# => Controlleur vue jeu libre
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class JeuLibreControleur

class JeuLibreControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele grille
		loadModel("Grille")
		loadModel("Score")
		loadModel("Jeu")

		#parametres fenetre
		@title  = "Sudoku - Jeu Libre"
		@content = {"grille" => nil, "score" => 0}
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

		if(@content.has_key?("difficulte"))
			niveau = @content["difficulte"]
		else
			niveau = 1
		end

		@content["grille"] = @Grille.generer(niveau)

		@Jeu.chrono = 600
		@Jeu.score  = 2000
		@Jeu.grille = @content["grille"]

		@Jeu.creerPartie(@content["pseudo"])
		donnees =@Jeu.chargerPartie(@content["pseudo"])
		
		puts donnees

		return self
	end
end
