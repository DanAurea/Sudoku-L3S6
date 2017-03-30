# 	Fichier contenant le choix de la difficulté pour le jeu libre
# 	
#   Author::        Valentin
#   Developers:     Valentin
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreNiveau < View

    @boxTop
    @boxBottom

	#===Methode miseEnplace
    #
    # Permet de mettre en place la fenetre(conteneurs)
    #
    # * *Args*    :
    #   - /
    # * *Returns* :
    #   - /
    #
	def miseEnPlace()        
        creerBoxTop()
        @boxBottom=Fenetre::creerBoxBottom()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

    ##
    #Creer la box vertical contenant les boutons des niveaux et le titre
    def creerBoxTop()
        ## Définis les classes des labels
        #titre
        titre = Fenetre::creerLabelType("<u>Choix difficulté</u>")
        titre.style_context.add_class("titre_menu")
        #pseudo
        pseudo = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
        pseudo.style_context.add_class("pseudo_menu")
        pseudo.halign = :end

        #Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo)
        }

        boutonFacile=Gtk::Button.new(:label => "Facile")
        boutonFacile.style_context.add_class("bouton_niveau_f")
        boutonFacile.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>1)
        }

        boutonMoyen=Gtk::Button.new(:label => "Moyen")
        boutonMoyen.style_context.add_class("bouton_niveau")
        boutonMoyen.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>2)
        }

        boutonDifficile=Gtk::Button.new(:label => "Difficile")
        boutonDifficile.style_context.add_class("bouton_niveau")
        boutonDifficile.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo, :difficulte=>3)
        }

        #add des boutons
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(titre)
        @boxTop.add(boutonFacile)
        @boxTop.add(boutonMoyen)
        @boxTop.add(boutonDifficile)
    end

    ##
	## @brief     Lance la construction du modèle
	## 			  de la vue.
	## 			  Méthode à définir dans tout les cas !
	## 			  Autrement pas de rendu de la page.
	##
	## @return     itself
	##
	def run()
		self.miseEnPlace
        Fenetre::css(:chemin => "/assets/css/FenetreNiveau.css")
		return self
	end

end
