# => Contient la classe FenetreNiveau pour la fenêtre de choix de la difficulté
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreNiveau
##
class FenetreNiveau < View
    # VI box
    @boxTop
    @boxBottom
    # VI bouton
    @boutonFacile
    @boutonMoyen
    @boutonDifficile
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
    ## Créer la box verticale contenant les boutons des choix de la difficulté et le titre
    ##
    ##
    def creerBoxTop()
        #labels
        @titreLabel = Fenetre::creerLabelType("<u>Choix difficulté</u>")
        @pseudoLabel = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
        @pseudoLabel.halign = :end

        #Creation des Boutons
        event_box=Gtk::EventBox.new.add(@pseudoLabel)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo)
        }

        @boutonFacile=Gtk::Button.new(:label => "Facile")
        @boutonFacile.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>1)
        }

        @boutonMoyen=Gtk::Button.new(:label => "Moyen")
        @boutonMoyen.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>2)
        }

        @boutonDifficile=Gtk::Button.new(:label => "Difficile")
        @boutonDifficile.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>3)
        }

        #add des boutons à la box
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(@titreLabel)
        @boxTop.add(@boutonFacile)
        @boxTop.add(@boutonMoyen)
        @boxTop.add(@boutonDifficile)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.style_context.add_class("titre_menu")
        @pseudoLabel.style_context.add_class("pseudo_menu")
        #css bouton
        @boutonFacile.style_context.add_class("bouton_niveau_f")
        @boutonMoyen.style_context.add_class("bouton_niveau")
        @boutonDifficile.style_context.add_class("bouton_niveau")
    end

    ##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
    def run()
      self.miseEnPlace
      Fenetre::css(:chemin => "/assets/css/FenetreNiveau.css")
      return self
  end
end
