# => Controlleur vue chargement d'une partie
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class ChargerControleur
#
class ChargerControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele grille
		loadModel("Grille")
		#parametres fenetre
		@title  = "Sudoku - Partie chargée"
		@content = {"grille" => nil}
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
