#   Contient la classe abstraite Fenetre regroupant les informations de base de chaque fenetre
#
#   Author::      PAVARD Valentin, DanAurea
#   Developers:   PAVARD Valentin, DanAurea
#   Version::     0.1
#   Copyright::   ©
#   License::     Distributes under the same terms as Ruby


module Fenetre

    @fenetre 
    @table
    @fenetrePrecedente

    ## Set a basic window
	@fenetre = Gtk::Window.new()

    @fournisseur = Gtk::CssProvider.new
    @fournisseur.load_from_resource(Core::ROOTPROJECT + "/assets/css/Fenetre.css")

    @fenetreStyle = @fenetre.style_context
    @fenetreStyle.add_provider(@fournisseur, Gtk::StyleProvider::PRIORITY_USER)

    # appliquerStyle(@window, provider)

	@fenetre.signal_connect('destroy') {
			detruire()
	}

	# Définis un accesseur pour le contexte de la fenêtre Gtk
	def Fenetre.fenetre()
		return @fenetre
	end   

    ## Montre la fenetre précédente
    def Fenetre.fenetrePrecedente()
        viderFenetre()

        @fenetrePrecedente.each() do |elt|
            @fenetre.add(elt)
        end

        @fenetre.show_all
    end

    ## Définis la fenetre précédente
    def Fenetre.fenetrePrecedente=(fenetre)
        @fenetrePrecedente = fenetre
    end

    ## Accesseur sur le layout
	def Fenetre.table()
		return @table
	end

    #=== Vide la fenêtre pour préparer la mise à jour.
    #
    #
    def Fenetre.viderFenetre()
        @fenetre.children.each() do |child|
            @fenetre.remove(child)
        end
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
    def Fenetre.detruire()
        Gtk.main_quit()
    end


    ##
    ## @brief      Applique un style css sur le widget
    ##
    ## @param      widget    Widget sur lequel appliquer un style
    ## @param      provider  
    ##
    ##
    def Fenetre.appliquerStyle(widget, provider)
        style_context = widget.style_context
        style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_USER)
        return unless widget.respond_to?(:children)
        widget.children.each do |child|
          apply_style(child, provider)
        end
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
        texte = "<span font_desc=\"Terminus 12 " + taillePolice.to_s + "\" foreground=\"" + couleur + "\"> #{unNomDeLabel} </span>\n"
        label=Gtk::Label.new()
        label.set_markup(texte)
        label.set_justify(Gtk::Justification::CENTER)
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
    		:parent => @fenetre,
    		:flags => Gtk::DialogFlags::DESTROY_WITH_PARENT,
    		:type => Gtk::MessageType::INFO,
    		:buttons => Gtk::ButtonsType::CLOSE,
    		:message => unTexte)
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
    		:parent => @fenetre,
    		:flags => Gtk::DialogFlags::DESTROY_WITH_PARENT,
    		:type => Gtk::MessageType::QUESTION,
    		:buttons => Gtk::ButtonsType::YES_NO,
    		:message => unTexte)
    	return messageErreur
    end
end
