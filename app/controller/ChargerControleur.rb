# =>
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	

##	
## Classe permettant de créer un controlleur pour la vue cFenetreCharger
##
class ChargerControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modèle grille
		loadModel("Grille")
		#paramètres fenêtre
		@title  = "Sudoku - Partie chargée"
		@content = {"grille" => nil}
	end

	##
    ## Méthode à définir dans tous les cas !
    ##
    ## @return 	self
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
