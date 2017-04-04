# => Contient la classe FenetreMenu pour la fenêtre du menu principal
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreMenu contenant le squelette du menu
##
class FenetreMenu < View
    # VI box
    @boxTop
    @boxBottom
    # VI bouton
    @boutonCharger
    @boutonNouveau
    @boutonStat
    @boutonScore
    @boutonReglage
    @boutonRegle
    @boutonAPropos
    @boutonQuitter
    # VI label
    @titreLabel

    ##
    ## Initialize
    ##
    def initialize()
        # VI box
        @boxTop = Gtk::Box.new(:vertical,0)
        @boxBottom = Gtk::Box.new(:horizontal, 0)
        # VI bouton
        @boutonCharger = Gtk::ToggleButton.new(:label => "Reprendre une partie")
        @boutonNouveau = Gtk::Button.new(:label => "Nouvelle partie")
        @boutonStat = Gtk::Button.new(:label => "Statistiques")
        @boutonScore = Gtk::Button.new(:label => "Meilleurs scores")
        @boutonReglage = Gtk::Button.new(:label => "Réglages")
        @boutonRegle = Gtk::Button.new(:label => "Règles de base")
        @boutonAPropos = Gtk::Button.new(:label => " About ")
        @boutonQuitter = Gtk::Button.new(:label => "Quitter")
        # VI label
        @titreLabel = Fenetre::creerLabelType("<u>Menu Principal</u>")
    end

    ##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
    def miseEnPlace()
        creerBoxTop()
        creerBoxBottom()
        ajoutCss()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

    ##
    ## Créer la box verticale contenant les boutons du menu et le titre
    ##
    ##
    def creerBoxTop()
        #Action des boutons
        @boutonCharger.signal_connect('clicked'){
            Core::changeTo("Charger", "pseudo": @pseudo)
        }

        @boutonNouveau.signal_connect('clicked'){
            Core::changeTo("NouvellePartie", "pseudo": @pseudo)
        }

        @boutonStat.signal_connect('clicked'){
            Core::changeTo("Statistiques", "pseudo": @pseudo)
        }

        @boutonScore.signal_connect('clicked'){
            Core::changeTo("Scores", "pseudo": @pseudo)
        }

        @boutonReglage.signal_connect('clicked'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        @boutonRegle.signal_connect('clicked'){
            Core::changeTo("Regles", "pseudo": @pseudo)
        }

        #add des boutons à la box
        @boxTop.add(@titreLabel)
        if(partieExiste(@pseudo))
            @boxTop.add(@boutonCharger)
        else
            @boxTop.add(Fenetre::creerLabelType(" "))
        end
        @boxTop.add(@boutonNouveau)
        @boxTop.add(@boutonStat)
        @boxTop.add(@boutonScore)
        @boxTop.add(@boutonReglage)
        @boxTop.add(@boutonRegle)
    end

    ##
    ## Créer la box horizontale contenant les boutons a propos et quitter
    ##
    ##
    def creerBoxBottom()
        #Action des boutons
        @boutonAPropos.signal_connect('clicked'){
            aPropos()
        }

        @boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #add des boutons à la box
        @boxBottom.halign = :center
        @boxBottom.add(@boutonAPropos)
        @boxBottom.add(@boutonQuitter)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.style_context.add_class("titre_menu")
        @titreLabel.set_margin_top(30)
        #css bouton
        @boutonCharger.set_margin(10)
        @boutonCharger.set_margin_left(100)
        @boutonCharger.set_margin_right(100)
        @boutonCharger.set_margin_top(15)
        @boutonNouveau.set_margin(10)
        @boutonNouveau.set_margin_left(100)
        @boutonNouveau.set_margin_right(100)
        @boutonStat.set_margin(10)
        @boutonStat.set_margin_left(100)
        @boutonStat.set_margin_right(100)
        @boutonScore.set_margin(10)
        @boutonScore.set_margin_left(100)
        @boutonScore.set_margin_right(100)
        @boutonReglage.set_margin(10)
        @boutonReglage.set_margin_left(100)
        @boutonReglage.set_margin_right(100)
        @boutonRegle.set_margin(10)
        @boutonRegle.set_margin_left(100)
        @boutonRegle.set_margin_right(100)
        @boutonAPropos.set_margin(40)
        @boutonQuitter.set_margin(40)
    end
    
    ##
    ## Créer la popup A propos pour l'explication du projet et des programmeurs
    ##
    ##
    def aPropos()
        fenetre = Gtk::AboutDialog.new()
        fenetre.set_program_name("Projet sudoku")
        fenetre.set_version("1.0")
        fenetre.set_copyright("(c) DogeTeam - Groupe B")
        fenetre.set_authors(["JEAN Marvin => Chef de projet", "COUSIN Brandon => Architecte", "PAVARD Valentin => Interface GUI", "DURAN Alizée => Documentaliste", "GUENVER Yann => Développeur", "TABOT Alexandre => Développeur", "BUSSEREAU Keryann => Développeur", "BODINEAU Bastien => Développeur"])
        fenetre.set_comments("Dans le cadre du module 176EN001 intitulé Génie Logiciel 2 :\n Application à la conception à l'université du Maine, nous devons réaliser une interface à aides visuelles à la réalisation d’un Sudoku. Cela permet d’aider un utilisateur à résoudre un Sudoku sans réfléchir. La grille du Sudoku sera générée sur ordinateur.")
        fenetre.set_transient_for(Fenetre::fenetre)
        fenetre.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        fenetre.set_title("Sudoku - A propos")
        fenetre.set_default_size(400,400)
        fenetre.border_width=0
        fenetre.set_resizable(false)
        
        fenetre.signal_connect('destroy') {
            fenetre.hide()
        }

        begin
            logo =GdkPixbuf::Pixbuf.new(:file => Core::ROOTPROJECT + "assets/img/logoS.jpeg", :width => 200, :height => 200)
            fenetre.set_logo(logo)
        rescue IOError => e
            puts e
            puts "Impossible de charger l'image du A Propos"
            exit
        end

        fenetre.run()
        fenetre.destroy()
    end

    ##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
	def run
		self.miseEnPlace()
		return self
	end
end
