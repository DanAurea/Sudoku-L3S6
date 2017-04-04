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

    ##
    ## Initialize
    ##
    def initialize()
        # VI box
        @boxTop = Gtk::Box.new(:vertical,0)
        @boxBottom = Fenetre::creerBoxBottom()
        # VI bouton
        @boutonApprentissage = Gtk::Button.new(:label => "Apprentissage avec aides")
        @boutonJeuLibre = Gtk::Button.new(:label => "Jeu libre")
        # VI label
        @titreLabel = Fenetre::creerLabelType("<u>Nouvelle partie</u>")
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
    ## Créer la box verticale contenant les boutons des choix du mode de jeu et le titre
    ##
    ##
    def creerBoxTop()
		#Action des boutons
        @boutonApprentissage.signal_connect('clicked'){
            Core::changeTo("Apprentissage", "pseudo": @pseudo)
        }

        @boutonJeuLibre.signal_connect('clicked'){
            Core::changeTo("Niveau", "pseudo": @pseudo)
        }

        #add des boutons à la box
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
        @titreLabel.set_margin_top(30)
        #css bouton
        @boutonApprentissage.set_margin_top(100)
        @boutonApprentissage.set_margin_bottom(50)
        @boutonApprentissage.set_margin_left(100)
        @boutonApprentissage.set_margin_right(100)
        @boutonJeuLibre.set_margin_bottom(50)
        @boutonJeuLibre.set_margin_left(100)
        @boutonJeuLibre.set_margin_right(100)
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
