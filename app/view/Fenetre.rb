#   Contient la classe abstraite Fenetre regroupant les informations de base de chaque fenetre
#
#   Author::      PAVARD Valentin
#   Version::     0.1
#   Copyright::   ©
#   License::     Distributes under the same terms as Ruby


module Fenetre

    @fenetre
    @table
    @fenetrePrecedente

	@fenetre = Gtk::Window.new()
	@fenetre.signal_connect('destroy') {
			Gtk.main_quit
	}

	# Définis un accesseur pour le contexte de la fenêtre Gtk
	def Fenetre.fenetre()
		return @fenetre
	end   

    # Définis un accesseur pour la table
	def Fenetre.table()
		return @table
	end

    # Définis un accesseur pour la fenetre precedente de la fenetre actuelle
    def Fenetre.fenetrePrecedente()
        return @fenetrePrecedente
    end

    #===Methode detruire
    #
    # Permet de quitter l'application et de detruire la fenetre
    #
    # * *Args*    :
    #   - /
    # * *Returns* :
    #   - /
    #
    def detruire()
        puts "Fin de la fenetre #{self.class}"
        Gtk.main_quit()
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
    def Fenetre.creerLabelType(unNomDeLabel, taillePolice, couleur,bSouligne)
        #Creation du Label
        if bSouligne
            texte = "<span font_desc=\"Comic sans MS " + taillePolice.to_s + "\" foreground=\"" + couleur + "\"><u> #{unNomDeLabel} </u></span>\n"
        else
            texte = "<span font_desc=\"Comic sans MS " + taillePolice.to_s + "\" foreground=\"" + couleur + "\"> #{unNomDeLabel} </span>\n"
        end
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

    ##===Methode creerFondEcran
    #
    # Creer le fond d'ecran
    #
    # * *Args*    :
    #   - /
    # * *Returns* :
    #   - image -> une image de fond
    #
    def creerFondEcran(x,y)
        begin
            tmp= GdkPixbuf::Pixbuf.new(:file => Core::ROOTPROJECT + "assets/img/fond.jpg", :width => x, :height => y)
            image = Gtk::Image.new(tmp)
            return image
        rescue IOError => e
            puts e
            puts "Impossible de charger l'image de fond"
            exit
        end
    end
end
