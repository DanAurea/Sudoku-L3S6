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

    ##
    ## Initialize
    ##
    def initialize()
        # VI box
        @boxTop = Gtk::Box.new(:vertical,0)
        @boxBottom = Fenetre::creerBoxBottom()
        # VI bouton
        @boutonFacile = Gtk::Button.new(:label => "Facile")
        @boutonMoyen = Gtk::Button.new(:label => "Moyen")
        @boutonDifficile = Gtk::Button.new(:label => "Difficile")
        # VI label
        @titreLabel = Fenetre::creerLabelType("<u>Choix difficulté</u>")
    end

    ##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
    def miseEnPlace()
        creerBoxTop()
        ajoutCss()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

    ##
    ## Créer la box verticale contenant les boutons des choix de la difficulté et le titre
    ##
    ##
    def creerBoxTop()
        #Action des boutons
        @boutonFacile.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>Jeu::FACILE)
        }

        @boutonMoyen.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>Jeu::MOYEN)
        }

        @boutonDifficile.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>Jeu::DIFFICILE)
        }

        #add des boutons à la box
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
        @titreLabel.set_margin_top(30)
        #css bouton
        @boutonFacile.set_margin_top(70)
        @boutonFacile.set_margin_bottom(40)
        @boutonFacile.set_margin_left(100)
        @boutonFacile.set_margin_right(100)
        @boutonMoyen.set_margin_bottom(40)
        @boutonMoyen.set_margin_left(100)
        @boutonMoyen.set_margin_right(100)
        @boutonDifficile.set_margin_bottom(40)
        @boutonDifficile.set_margin_left(100)
        @boutonDifficile.set_margin_right(100)
    end

    ##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
    def run()
        self.miseEnPlace()
        return self
    end
end
