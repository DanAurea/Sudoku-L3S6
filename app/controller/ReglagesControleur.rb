# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
##
## Classe permettant de créer un contrôleur pour la vue FenetreReglages
##
class ReglagesControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modèle utilisateur
		loadModel("Utilisateur")
		loadModel("Configuration")

		#paramètres fenêtre
		@title     = "Sudoku - Réglages"
		@width     = 600
		@height    = 550
		@resizable = false
		@position  = "CENTER_ALWAYS"

	end


	##
	## Enregistre les paramètres en base de données
	##
	## @param      pseudo      Pseudo de l'utilisateur
	## @param      config      Configuration de l'utilisateur
	##
	## @return     self
	##
	def enregistrerReglages(pseudo, config)
		@Configuration.enregistrer(pseudo, config)
		return self
	end


	##
	## Réinitialise l'utilisateur avec les configurations par défaut
	##
	## @return     { description_of_the_return_value }
	##
	def resetUtilisateur()
		@Utilisateur.reinitialiserUtilisateur(@content["pseudo"])
	end

	##
    ## Convertit un gdk color en composantes sous forme d'une chaîne séparée par une virgule
    ##
    ## @param   gdkColor        GDK::Color
    ##
    ## @return  Les composantes sous forme de chaîne
    ##
    def couleur(gdkColor)
        return @Configuration.couleur(gdkColor)
    end


    ##
    ## Crée un Gdk::Color à partir d'une chaîne
    ##
    ## @param   composantes     Composantes ("r,g,b")
    ##
    ## @return  Gdk::Color
    ##
    def creerCouleur(composantes)
    	return @Configuration.creerCouleur(composantes)
    end

	##
    ## Méthode à définir dans tous les cas !
    ##
    ## @return  self
    ##
	def run()
		@content["config"] = @Configuration.getConfiguration(@content["pseudo"])

		return self
	end
end
