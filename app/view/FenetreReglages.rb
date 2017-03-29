# 	Fichier contenant la gestion des reglages(taille, couleur)
# 	
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreReglages < View

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
		## Définis les classes de titres
		#titre
		titre = Fenetre::creerLabelType("<u>Réglages</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")

		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }
    	
        boutonRetour=Gtk::Button.new(:label => "Retour")
        boutonRetour.signal_connect('clicked'){
            Core::back()
        }

        boutonQuitter=Gtk::Button.new(:label => "Quitter")
        boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #attach des boutons
        Fenetre::box.add(titre)
        Fenetre::box.add(event_box)
        Fenetre::box.add(boutonRetour)
        Fenetre::box.add(boutonQuitter)
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
		self.miseEnPlace()
		Fenetre::css(:chemin => "/assets/css/FenetreReglages.css")
		return self
	end

end
