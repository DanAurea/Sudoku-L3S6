# => Contient la classe FenetreNouvellePartie qui propose le mode aventure ou apprentissage
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreNouvellePartie
##
class FenetreNouvellePartie < View
    # VI box
    @boxTop
    @boxBottom
    # VI bouton
    @boutonApprentissage
    @boutonJeuLibre
    # VI label
    @titreLabel
    @pseudoLabel

    ##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
    def miseEnPlace()        
        creerBoxTop()
        @boxBottom=Fenetre::creerBoxBottom()
        ajoutCss()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

	##
    ## Créer la box verticale contenant les boutons des choix du mode de jeu et le titre
    ##
    ##
    def creerBoxTop()
		#labels
		@titreLabel = Fenetre::creerLabelType("<u>Nouvelle partie</u>")
        @pseudoLabel = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
        @pseudoLabel.halign = :end

		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(@pseudoLabel)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        @boutonApprentissage=Gtk::Button.new(:label => "Apprentissage avec aides")
        @boutonApprentissage.signal_connect('clicked'){
            Core::changeTo("Apprentissage", "pseudo": @pseudo)
        }

        @boutonJeuLibre=Gtk::Button.new(:label => "Jeu libre")
        @boutonJeuLibre.signal_connect('clicked'){
            Core::changeTo("Niveau", "pseudo": @pseudo)
        }

        #add des boutons à la box
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(@titreLabel)
        @boxTop.add(@boutonApprentissage)
        @boxTop.add(@boutonJeuLibre)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.style_context.add_class("titre_menu")
        @pseudoLabel.style_context.add_class("pseudo_menu")
        #css bouton
        @boutonApprentissage.style_context.add_class("bouton_nouvelle_partie_f")
        @boutonJeuLibre.style_context.add_class("bouton_nouvelle_partie")
    end

    ##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
	def run()
		self.miseEnPlace
        Fenetre::css(:chemin => "/assets/css/FenetreNouvellePartie.css")
		return self
	end
end
