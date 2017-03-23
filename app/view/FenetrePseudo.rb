#   Contient la classe representant une fenetre pour le choix du pseudo
#
# 	Author:: 		PAVARD Valentin, DanAurea
# 	Developers: 	PAVARD Valentin, DanAurea
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
		titre = Fenetre::creerLabelType("Choix du pseudo")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo=Fenetre::creerLabelType(" Votre pseudo : ")
		pseudo.style_context.add_class("label_menu")
		
		#Creation des Boutons
		entryPseudo=Gtk::Entry.new()
		entryPseudo.set_max_length(15)

		boutonValider=Gtk::Button.new(:label => "Valider")
		boutonValider.signal_connect('button_press_event'){
		      @controller.actionBoutonValider(entryPseudo)
		}

		boutonQuitter=Gtk::Button.new(:label => "Quitter")
		boutonQuitter.signal_connect('clicked'){
		  		Fenetre::detruire()
		}

		#attach des boutons
		Fenetre::table.attach(titre,0,10,2,3)
		Fenetre::table.attach(pseudo,0,10,4,5)
		Fenetre::table.attach(entryPseudo,3,7,5,6)
		Fenetre::table.attach(boutonQuitter,2,4,7,8)
		Fenetre::table.attach(boutonValider,6,8,7,8)
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
