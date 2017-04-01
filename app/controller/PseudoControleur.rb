##
##	@brief Controleur de la fenetre de pseudo
##

class PseudoControleur < Controller
	
	def initialize()
		## Charge le modele utilisateur
		loadModel("Utilisateur")
		@title = "Sudoku - Pseudo"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"

	end

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

	#===Methode actionBoutonValider
	#
	# Action du bouton valider(verification pseudo)
	#
	# * *Args*    :
	#   - /
	# * *Returns* :
	#   - /
	#  	
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

	def pseudoExiste(pseudo)
		return @Utilisateur.rechercherUtilisateur(pseudo)
	end

	def run()
		return self	
	end

end
