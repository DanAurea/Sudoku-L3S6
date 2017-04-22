# => Controlleur vue principale
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
##
## Classe permettant de créer un contrôleur pour la vue FenetrePrincipale
##
class PrincipaleControleur < Controller
	
	##
    ## Initialize
    ##
	def initialize ()
		#paramètres fenêtre
		@title = "Sudoku"
		@resizable = false
	end

	##
    ## Méthode à définir dans tous les cas !
    ##
    ## @return 	self
    ##
	def run()
		return self
	end
end
