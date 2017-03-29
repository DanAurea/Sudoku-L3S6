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
		
		## Définis les classes de titres
		#titre
		titre = Fenetre::creerLabelType("<u>Choix du pseudo</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo=Fenetre::creerLabelType(" Votre pseudo : ")
		pseudo.style_context.add_class("label_field_pseudo")
		
		#Creation des Boutons
		entryPseudo=Gtk::Entry.new()
		entryPseudo.set_max_length(15)
		entryPseudo.style_context.add_class("field_pseudo")

		boutonValider=Gtk::Button.new(:label => "Valider")
		boutonValider.signal_connect('button_press_event'){
		      @controller.actionBoutonValider(entryPseudo)
		}

		boutonQuitter=Gtk::Button.new(:label => "Quitter")
		boutonQuitter.signal_connect('clicked'){
		  		Fenetre::detruire()
		}

		#attach des boutons
		Fenetre::box.add(titre)
		Fenetre::box.add(pseudo)
		Fenetre::box.add(entryPseudo)
		Fenetre::box.add(Fenetre::creerLabelType(" "))
		Fenetre::box.add(boutonQuitter)
		Fenetre::box.add(boutonValider)
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
