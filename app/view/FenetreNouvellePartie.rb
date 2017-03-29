# 	Fichier contenant la gestion de la nouvelle partie
# 	
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreNouvellePartie < View

	def initialize()
		
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
	def miseEnPlace()
		## Définis les classes des labels
		#titre
		titre = Fenetre::creerLabelType("<u>Nouvelle partie</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")

		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        boutonApprentissage=Gtk::Button.new(:label => "Apprentissage avec aides")
        boutonApprentissage.style_context.add_class("bouton_nouvelle_partie")
        boutonApprentissage.signal_connect('clicked'){
            Core::changeTo("Apprentissage", "pseudo": @pseudo)
        }

        boutonJeuLibre=Gtk::Button.new(:label => "Jeu libre")
        boutonJeuLibre.style_context.add_class("bouton_nouvelle_partie")
        boutonJeuLibre.signal_connect('clicked'){
            Core::changeTo("Niveau", "pseudo": @pseudo)
        }

        boutonRetour=Gtk::Button.new(:label => "Retour")
        boutonRetour.style_context.add_class("bouton_bottom")
        boutonRetour.signal_connect('clicked'){
        	Core::back()
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
        boxTop.add(boutonApprentissage)
        boxTop.add(boutonJeuLibre)

        boxBottom=Gtk::Box.new(:horizontal, 0)
        boxBottom.halign = :center
        boxBottom.add(boutonRetour)
        boxBottom.add(boutonQuitter)
        
        Fenetre::box.add(boxTop)
        Fenetre::box.add(boxBottom)
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
        Fenetre::css(:chemin => "/assets/css/FenetreNouvellePartie.css")
		return self
	end

end
