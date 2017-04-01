# => Controlleur vue choix pseudo
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class PseudoControleur
#
class PseudoControleur < Controller
	
	##
    ## Initialize
    ##
	def initialize()
		#charge le modele utilisateur
		loadModel("Utilisateur")
		#parametres fenetre
		@title = "Sudoku - Pseudo"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"

	end

	##
	## Action après clic sur le bouton valider pour choix du pseudo
	##
	## @param 	message message popup
	## @param 	entreePseudo widget pseudo
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
	## Action du bouton valider(verification pseudo)
	##
	## @param 	entreePseudo widget pseudo
	##
	##
  	def actionBoutonValider(entreePseudo)
  		if(entreePseudo.text == "")
  			messageErreur = Fenetre::creerPopup("Vous devez entrer un pseudo valide pour continuer!", "CLOSE")
  			messageErreur.run()
  			messageErreur.destroy()
  		elsif self.pseudoExiste(entreePseudo.text)
  			actionValider("Ce pseudo existe déjà, êtes vous '#{entreePseudo.text}'?", entreePseudo)
  		else
			if actionValider("Pseudo inconnu, creer un nouveau profil?", entreePseudo)
				@Utilisateur.creerUtilisateur(entreePseudo.text)
			end
  		end
  	end

  	##
  	## Permet de savoir si le pseudo existe deja dans la base
  	##
  	## @param 	pseudo  pseudo voulu par l'utilisateur
  	##
  	## @return 	boolean
  	##
	def pseudoExiste(pseudo)
		return @Utilisateur.rechercherUtilisateur(pseudo)
	end

	##
    ## Méthode à définir dans tout les cas !
    ##
    ## @return self
    ##
	def run()
		return self	
	end
end
