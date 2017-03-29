# 	squelette du menu
# 	
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 
class FenetreMenu < View

    #===Methode miseEnplace
    #
    # Permet de mettre en place la fenetre(taille, informations, conteneurs)
    #
    # * *Args*    :
    #   - /
    # * *Returns* :
    #   - /
    #
    def miseEnPlace()
    	## Définis les classes des labels
		#titre
		titre = Fenetre::creerLabelType("<u>Menu Principal</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")
        pseudo.halign = :end

        #Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        boutonCharger=Gtk::ToggleButton.new(:label => "Reprendre une partie")
        boutonCharger.style_context.add_class("bouton_menu_f")
        boutonCharger.signal_connect('clicked'){
            Core::changeTo("Charger", "pseudo": @pseudo)
        }

        boutonNouveau=Gtk::Button.new(:label => "Nouvelle partie")
        boutonNouveau.style_context.add_class("bouton_menu")
        boutonNouveau.signal_connect('clicked'){
            Core::changeTo("NouvellePartie", "pseudo": @pseudo)
        }

        boutonStat=Gtk::Button.new(:label => "Statistiques")
        boutonStat.style_context.add_class("bouton_menu")
        boutonStat.signal_connect('clicked'){
            Core::changeTo("Statistiques", "pseudo": @pseudo)
        }

        boutonScore=Gtk::Button.new(:label => "Meilleurs scores")
        boutonScore.style_context.add_class("bouton_menu")
        boutonScore.signal_connect('clicked'){
            Core::changeTo("Scores", "pseudo": @pseudo)
        }

        boutonReglage=Gtk::Button.new(:label => "Réglages")
        boutonReglage.style_context.add_class("bouton_menu")
        boutonReglage.signal_connect('clicked'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        boutonRegle=Gtk::Button.new(:label => "Règles de base")
        boutonRegle.style_context.add_class("bouton_menu")
        boutonRegle.signal_connect('clicked'){
            Core::changeTo("Regles", "pseudo": @pseudo)
        }

        boutonAPropos=Gtk::Button.new(:label => " About ")
        boutonAPropos.style_context.add_class("bouton_bottom")
        boutonAPropos.signal_connect('clicked'){
            aPropos()
        }

        boutonQuitter=Gtk::Button.new(:label => "Quitter")
        boutonQuitter.style_context.add_class("bouton_bottom")
        boutonQuitter.signal_connect('clicked'){
        	Fenetre::detruire()
        }

        #add des boutons
        boxTop=Gtk::Box.new(:vertical,0)
        boxTop.add(event_box)
        boxTop.add(titre)
        if(partieExiste(@pseudo))
            boxTop.add(boutonCharger)
        else
            boxTop.add(Fenetre::creerLabelType(" "))
        end
        boxTop.add(boutonNouveau)
        boxTop.add(boutonStat)
        boxTop.add(boutonScore)
        boxTop.add(boutonReglage)
        boxTop.add(boutonRegle)

        boxBottom=Gtk::Box.new(:horizontal, 0)
        boxBottom.halign = :center
        boxBottom.add(boutonAPropos)
        boxBottom.add(boutonQuitter)
        
        Fenetre::box.add(boxTop)
        Fenetre::box.add(boxBottom)
    end

    def aPropos()
    	#popup explication du projet et des programmeurs
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
	## @brief     Lance la construction du modèle
	## 			  de la vue.
	## 			  Méthode à définir dans tout les cas !
	## 			  Autrement pas de rendu de la page.
	##
	## @return     itself
	##
	def run
		self.miseEnPlace()
        Fenetre::css(:chemin => "/assets/css/FenetreMenu.css")
		return self
	end
end
