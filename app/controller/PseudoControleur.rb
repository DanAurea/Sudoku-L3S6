# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
##
## Classe permettant de créer un contrôleur pour la vue FenetrePseudo
##
class PseudoControleur < Controller
	
	##
    ## Initialize
    ##
	def initialize()
		#charge le modèle utilisateur
		loadModel("Utilisateur")
		
		#paramètres fenêtre
		@title = "Sudoku - Pseudo"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"

	end

	##
	## Action après clic sur le bouton valider pour choix du pseudo
	##
	## @param 	message 		Message popup
	## @param 	entreePseudo 	Widget pseudo
	##
	## @return 	boolean
	##
	def actionValider(message, entreePseudo)
		messageQuestion = Fenetre::creerPopup(message, "YES_NO")
		reponse = messageQuestion.run()
        action = false

        if(reponse == Gtk::ResponseType::YES)
        	## Ajoute l'entête de la fenêtre avec le profil utilisateur
        	## puis change de page
        	Header.profil(entreePseudo.text)
        	Core::changeTo("Menu", "pseudo": entreePseudo.text)
        	action = true
        else
            entreePseudo.text=""
            action = false
        end
        
        messageQuestion.destroy()
        return action
	end	
	
	##
	## Action du bouton valider (vérification pseudo)
	##
	## @param 	entreePseudo 	Widget pseudo
	##
  	def actionBoutonValider(entreePseudo)
  		if(entreePseudo.text == "")
  			messageErreur = Fenetre::creerPopup("Vous devez entrer un pseudo valide pour continuer!", "CLOSE")
  			messageErreur.run()
  			messageErreur.destroy()
  		elsif self.pseudoExiste(entreePseudo.text)
  			actionValider("Ce pseudo existe déjà, êtes vous '#{entreePseudo.text}'?", entreePseudo)
  		else
			if actionValider("Pseudo inconnu, créer un nouveau profil?", entreePseudo)
				@Utilisateur.creerUtilisateur(entreePseudo.text)
			end
  		end
  	end

  	##
  	## Permet de savoir si le pseudo existe déjà dans la base
  	##
  	## @param 	pseudo  	Pseudo voulu par l'utilisateur
  	##
  	## @return 	boolean
  	##
	def pseudoExiste(pseudo)
		return @Utilisateur.rechercherUtilisateur(pseudo)
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
