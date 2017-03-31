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
		messageQuestion=Fenetre::creerPopupQuestion(message)
        reponse=messageQuestion.run()
        action = FALSE

        if(reponse == Gtk::ResponseType::YES)
        	Core::changeTo("Menu", "pseudo": entreePseudo.text)
        	action = TRUE
        else
            entreePseudo.text=""
            action = FALSE
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
  			messageErreur=Fenetre::creerPopupErreur("Vous devez entrer un pseudo valide pour continuer!")
  		elsif self.pseudoExiste(entreePseudo.text) == true
  			actionValider("Ce pseudo existe déjà, êtes vous '#{entreePseudo.text}'?", entreePseudo)
  		else
			if actionValider("Pseudo inconnu, creer un nouveau profil?", entreePseudo)
				@Utilisateur.creerUtilisateur(entreePseudo.text)
			end
  		end
		

  	end

	def pseudoExiste(pseudo)
		
	end

	def run()
		return self	
	end

end
