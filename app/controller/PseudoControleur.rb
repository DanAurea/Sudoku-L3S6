##
##	@brief Controleur de la fenetre de pseudo
##

class PseudoControleur < Controller
	
	def initialize()
		## Charge le modele utilisateur
		loadModel("Utilisateur")
		@title = "Sudoku - Pseudo"
	end

	def actionValider(message, entreePseudo)
		messageQuestion=Fenetre::creerPopupQuestion(message)
        reponse=messageQuestion.run()
        
        if(reponse == Gtk::Dialog::RESPONSE_YES)
        	Core::changeTo("Menu", "pseudo": entreePseudo.text)
        elsif(reponse == Gtk::Dialog::RESPONSE_NO)
            entreePseudo.text=""
        end
        
        messageQuestion.destroy()
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
			actionValider("Pseudo inconnu, creer un nouveau profil?", entreePseudo)
  		end

  	end

	def pseudoExiste(pseudo)
		return @Utilisateur.pseudoExiste(pseudo)
	end

	def run()
		
		return self	
	end

end
