module Fenetre

	@fenetre = Gtk::Window.new()
	@fenetre.signal_connect('destroy') {
			Gtk.main_quit
	}

	## Définis un accesseur pour le contexte de la fenêtre Gtk
	def Fenetre.fenetre()
		return @fenetre
	end

	def Fenetre.table()
		return @table
	end

	 #===Methode miseEnplace
    #
    # Permet de mettre en place la fenetre(conteneurs)
    #
    # * *Args*    :
    #   - /
    # * *Returns* :
    #   - /
    #
    def Fenetre.miseEnPlace()
        #Conteneur table
        @table=Gtk::Table.new(10,12,false)
        @fenetre.add(@table)
        #espace
        1.upto(10){|i|
        	@table.attach(self.creerLabelType(" ", 20, "#FF0000"),0,10,i,i+1)
        }
    end

    #===Methode creerLabelType
    #
    # Creer un label type
    #
    # * *Args*    :
    #   - +unNomDeLabel+ -> Chaine de caracteres representant le texte du label
    # * *Returns* :
    #   - unLabel -> Label
    #
    def Fenetre.creerLabelType(unNomDeLabel, taillePolice, couleur)
        #Creation du Label
        texte = "<span font_desc=\"Comic sans MS" + taillePolice.to_s + "\" foreground=\"" + couleur + "\"> #{unNomDeLabel} </span>\n"
        label=Gtk::Label.new()
        label.set_markup(texte)
        label.set_justify(Gtk::JUSTIFY_CENTER)
        return label
    end

    ##===Methode creerPopupErreur
    #
    # Creer une popup d'avertissement
    #
    # * *Args*    :
    #   - +unTexte+ -> Chaine de caracteres informative
    # * *Returns* :
    #   - messageErreur -> MessageDialog
    #
    def Fenetre.creerPopupErreur(unTexte)
    	messageErreur = Gtk::MessageDialog.new(
    		@fenetre,
    		Gtk::Dialog::DESTROY_WITH_PARENT,
    		Gtk::MessageDialog::INFO,
    		Gtk::MessageDialog::BUTTONS_CLOSE,
    		unTexte)
    	messageErreur.run()
    	messageErreur.destroy()
    	return messageErreur
    end

    ##===Methode creerPopupQuestion
    #
    # Creer une popup question oui non
    #
    # * *Args*    :
    #   - +unTexte+ -> Chaine de caracteres informative
    # * *Returns* :
    #   - messageErreur -> MessageDialog
    #
    def Fenetre.creerPopupQuestion(unTexte)
    	messageErreur = Gtk::MessageDialog.new(
    		@fenetre,
    		Gtk::Dialog::DESTROY_WITH_PARENT,
    		Gtk::MessageDialog::QUESTION,
    		Gtk::MessageDialog::BUTTONS_YES_NO,
    		unTexte)
    	return messageErreur
    end

end