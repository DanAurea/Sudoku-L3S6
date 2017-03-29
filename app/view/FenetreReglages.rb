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

        # Couleur case base, couleur case surlignée, couleur texte, couleur indice, police de texte
        labelCouleurCaseBase = generate_label("Couleur des cases de base :")
        boutonCouleurCaseBase = Gtk::ColorButton.new

        labelCouleurCaseSelectionne = generate_label("Couleur des cases selctionnées :")
        boutonCouleurCaseSelectionne = Gtk::ColorButton.new

        labelCouleurTexte = generate_label("Couleur du texte :")
        boutonCouleurTexte = Gtk::ColorButton.new

        labelCouleurIndices = generate_label("Couleur des indices :")
        boutonCouleurIndices = Gtk::ColorButton.new

        labelPolice = generate_label("Police de texte :")
        boutonPolice = Gtk::FontButton.new

        boutonRetour=Gtk::Button.new(:label => "Retour")
        boutonRetour.signal_connect('clicked'){
            Core::back()
        }

        boutonQuitter=Gtk::Button.new(:label => "Quitter")
        boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #attach des boutons
        Fenetre::table.attach(titre,0,10,1,2)
        Fenetre::table.attach(event_box,7,10,0,1)

        Fenetre::table.attach(labelCouleurCaseBase,3,5,3,4)
        Fenetre::table.attach(boutonCouleurCaseBase,5,8,3,4)

        Fenetre::table.attach(labelCouleurCaseSelectionne,3,5,4,5)
        Fenetre::table.attach(boutonCouleurCaseSelectionne,5,8,4,5)

        Fenetre::table.attach(labelCouleurTexte,3,5,5,6)
        Fenetre::table.attach(boutonCouleurTexte,5,8,5,6)

        Fenetre::table.attach(labelCouleurIndices,3,5,6,7)
        Fenetre::table.attach(boutonCouleurIndices,5,8,6,7)

        Fenetre::table.attach(labelPolice,3,5,7,8)
        Fenetre::table.attach(boutonPolice,5,8,7,8)

        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
    end

    def generate_label(label)
      label = Gtk::Label.new(label)
      label.halign = :start
      label.valign = :center
      label.hexpand = :true
      label
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
