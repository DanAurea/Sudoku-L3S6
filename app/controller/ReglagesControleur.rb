# => Controlleur vue reglages
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class ReglagesControleur
#
class ReglagesControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele utilisateur
		loadModel("Utilisateur")
		loadModel("Configuration")

		#parametres fenetre
		@title     = "Sudoku - Réglages"
		@width     = 600
		@height    = 550
		@resizable = false
		@position  = "CENTER_ALWAYS"

	end


	##
	## @brief      Enregistre les paramètres en base de données
	##
	## @param      pseudo  Pseudo de l'utilisateur
	## @param      config  Configuration de l'utilisateur
	##
	## @return     self
	##
	def enregistrerReglages(pseudo, config)
		@Configuration.enregistrer(pseudo, config)
		return self
	end

	##
    ## @brief      Convertis un gdk color en composantes
    ##              sous forme d'une chaîne séparée par une virgule
    ##
    ## @param      gdkColor GDK::Color
    ##
    ## @return     Les composantes sous forme de chaîne
    ##
    def couleur(gdkColor)
        return @Configuration.couleur(gdkColor)
    end


    ##
    ## @brief      Crée unn gdk color à partir d'une chaîne
    ##
    ## @param      composantes  Composantes ("r,g,b")
    ##
    ## @return     Gdk::Color
    ##
    def creerCouleur(composantes)
    	return @Configuration.creerCouleur(composantes)
    end

	##
    ## Méthode à définir dans tout les cas !
    ##
    ## @return self
    ##
	def run()
		@content["config"] = @Configuration.getConfiguration(@content["pseudo"])
		puts @content

		return self
	end
end
