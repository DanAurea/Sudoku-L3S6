#   Contient la classe representant une fenetre pour le choix du pseudo
#
#   Author::      PAVARD Valentin
#   Version::     0.1
#   Copyright::   ©
#   License::     Distributes under the same terms as Ruby


class FenetrePseudo < View 

	@label
	@entryPseudo
	@pseudo
	@boutonValider
	@boutonQuitter


	#===Methode miseEnplace
    #
    # Permet de mettre en place la fenetre(taille, informations, conteneurs)
    #
    # * *Args*    :
    #   - /
    # * *Returns* :
    #   - /
	def miseEnPlace()

		Fenetre::table.attach(Fenetre::creerLabelType("<u>Choix du pseudo</u>", 40, "#FFFFFF"),0,10,2,3)

		#Creation des Boutons
		@label=Fenetre::creerLabelType(" Votre pseudo : ", 20, "#FFFFFF")
		
		@entryPseudo=Gtk::Entry.new()
		@entryPseudo.set_max_length(15)

		@boutonValider=Gtk::Button.new(Gtk::Stock::APPLY)
		@boutonValider.signal_connect('button_press_event'){
		      self.actionBoutonValider()
		}

		@boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
		@boutonQuitter.signal_connect('clicked'){
		  		Fenetre::detruire()
		}

		Fenetre::table.attach(@label,3,7,4,5)
		Fenetre::table.attach(@entryPseudo,3,7,5,6)
		Fenetre::table.attach(@boutonValider,3,7,7,8)
		Fenetre::table.attach(@boutonQuitter,7,9,11,12)
		Fenetre::table.attach(Fenetre::creerFondEcran(900,500),0,10,0,12)
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
  	def actionBoutonValider()
  		if(@entryPseudo.text=="")
  			@messageErreur=Fenetre::creerPopupErreur("Vous devez entrer un pseudo valide pour continuer!")
  		elsif @controller.pseudoExiste(@entryPseudo.text)==true
  				@messageQuestion=Fenetre::creerPopupQuestion("Ce pseudo existe déjà, êtes vous '#{@entryPseudo.text}'?")
  		        reponse=@messageQuestion.run()
  		        if(reponse == Gtk::Dialog::RESPONSE_YES)
  		        	@controller.pseudoValider(@entryPseudo.text)
  		        	Core::load("Menu")
  		        elsif(reponse == Gtk::Dialog::RESPONSE_NO)
  		            @entryPseudo.text=""
  		        end
  		        @messageQuestion.destroy()
  		else
  			@messageQuestion=Fenetre::creerPopupQuestion("Pseudo inconnu, creer un nouveau profil?")
			reponse=@messageQuestion.run()
  		    if(reponse == Gtk::Dialog::RESPONSE_YES)
  		      	@controller.profil(@entryPseudo.text)
  		      	Core::load("Menu")
  		    elsif(reponse == Gtk::Dialog::RESPONSE_NO)
  		        @entryPseudo.text=""
  		    end
  		    @messageQuestion.destroy()
  		end
  	end

	##
	## @brief     Lance la construction du modèle
	## 			  de la vue.
	## 			  Méthode à définir dans tout les cas !
	## 			  Autrement pas de rendu de la page.
	##
	## @return     itself
	##
	def run
		self.miseEnPlace
		return self
	end
end
