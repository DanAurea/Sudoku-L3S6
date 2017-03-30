#   Contient la classe representant une fenetre pour le choix du pseudo
#
# 	Author:: 		Valentin, DanAurea
# 	Developers: 	Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
#   License::     Distributes under the same terms as Ruby

class FenetrePseudo < View 

	#===Methode miseEnplace
    #
    # Permet de mettre en place la fenetre(taille, informations, conteneurs)
    #
    # * *Args*    :
    #   - /
    # * *Returns* :
    #   - /
	def miseEnPlace()
		
		## Définis les classes des labels
		#titre
		titre = Fenetre::creerLabelType("<u>Choix du pseudo</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo=Fenetre::creerLabelType(" Votre pseudo : ")
		pseudo.set_name("label_field_pseudo")
		
		#Creation des Boutons
		entryPseudo=Gtk::Entry.new()
		entryPseudo.set_max_length(15)
		entryPseudo.style_context.add_class("field_pseudo")

		entryPseudo.signal_connect("activate"){
			@controller.actionBoutonValider(entryPseudo)
		}

		boutonValider=Gtk::Button.new(:label => "Valider")
		boutonValider.style_context.add_class("bouton_bottom")
		boutonValider.signal_connect('button_press_event'){
		      @controller.actionBoutonValider(entryPseudo)
		}

		boutonQuitter=Gtk::Button.new(:label => "Quitter")
		boutonQuitter.style_context.add_class("bouton_bottom")
		boutonQuitter.signal_connect('clicked'){
		  		Fenetre::detruire()
		}

		#add des boutons
		boxTop=Gtk::Box.new(:vertical,0)
		boxTop.add(titre)
		boxTop.add(pseudo)
		boxTop.add(entryPseudo)

		boxBottom=Gtk::Box.new(:horizontal, 0)
		boxBottom.halign = :center
		boxBottom.add(boutonQuitter)
		boxBottom.add(boutonValider)
		
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
	def run
		self.miseEnPlace
		Fenetre::css(:chemin => "/assets/css/FenetrePseudo.css")
		return self
	end
end
