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

		Fenetre::table.attach(self.creerLabelType("Choix du pseudo", 40, "#FFFFFF",true),0,10,2,3)

		#Creation des Boutons
		@label=self.creerLabelType(" Votre pseudo : ", 20, "#FFFFFF",false)
		
		@entryPseudo=Gtk::Entry.new()
		@entryPseudo.set_max_length(15)
		@entryPseudo.signal_connect('activate') {
			@pseudo=@entryPseudo.text
		}

		@boutonValider=Gtk::Button.new(Gtk::Stock::APPLY)
		@boutonValider.signal_connect('button_press_event'){
		      actionBoutonValider()
		}

		@boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
		@boutonQuitter.signal_connect('clicked'){
		  		self.detruire()
		}

		Fenetre::table.attach(@label,3,7,4,5)
		Fenetre::table.attach(@entryPseudo,3,7,5,6)
		Fenetre::table.attach(@boutonValider,3,7,7,8)
		Fenetre::table.attach(@boutonQuitter,7,9,11,12)
		Fenetre::table.attach(self.creerFondEcran(900,500),0,10,0,12)
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
  			@messageErreur=self.creerPopupErreur("Vous devez entrer un pseudo valide pour continuer!")
  		end






  		passage=false
  		#pseudo invalide
  		
  		
  		if(passage==false)
  		#A MOFIDIER IMPORTANT!!!!!!
  			@tabPseudo.each{|contenu|
				#si pseudo existe deja
  		        if(@entryPseudo.text==contenu)
  		            @messageQuestion=self.creerPopupQuestion("Ce pseudo existe déjà, êtes vous '#{contenu}'?")
  		            reponse=@messageQuestion.run()
  		            if(reponse == Gtk::Dialog::RESPONSE_YES)
  		            	@entryPseudo.activate
  		            	#Fenetre du menu principal
  		                	menuPrincipal=FenetreMenuPrincipal.creer(@pseudo)
  		                    self.fenetre().hide_all()
  		                    menuPrincipal.fenetre().show_all()
  		            elsif(reponse == Gtk::Dialog::RESPONSE_NO)
  		                @entryPseudo.text=""
  		            end
  		           	@messageQuestion.destroy()
  		            passage=true;
  		        end
  		    }
  		end

  		if(passage==false)
  		    @messageQuestion=self.creerPopupQuestion("Pseudo inconnu, creer un nouveau profil?")
  		    reponse=@messageQuestion.run()
  		    if(reponse == Gtk::Dialog::RESPONSE_YES)
  		      	@entryPseudo.activate
  		        #Fenetre du menu principal
  		        menuPrincipal=FenetreMenuPrincipal.creer(@pseudo)
  		        self.fenetre().hide_all()
  		        menuPrincipal.fenetre().show_all()
  		    elsif(reponse == Gtk::Dialog::RESPONSE_NO)
  		        @entryPseudo.text=""
  		    end
  		    @messageQuestion.destroy()
  		end
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
