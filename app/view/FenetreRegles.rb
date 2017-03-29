# 	Fichier contenant les règles de base dans le jeu
# 	
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreRegles < View

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
		titre = Fenetre::creerLabelType("<u>Règles</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")
		#regles enoncées
    	texte="
    	- Un sudoku classique contient 9 lignes et 9 colonnes,\n
    	soit 81 cases au total.\n 
    	- Le but du jeu est de remplir ces cases avec des chiffres\n
    	allant de 1 à 9 en veillant toujours à ce qu'un même chiffre \n 
    	ne figure qu'une seule fois par colonne, une seule fois par\n 
    	ligne et une seule fois par carré de 9 cases(appelé région).\n
    	- Au début du jeu, une vingtaine de chiffres sont déjà placés\n 
    	et il vous reste à trouver les autres. En effet, une grille\n 
    	initiale de sudoku corresctement constituée ne peut aboutir qu'à\n
    	une et une seule solution. Pour trouver les chiffres manquants,\n 
    	tout est une question de logique et d'observation.\n
    	- Suivez le tutoriel pour vous faciliter la tache et apprendre\n 
    	certaines techniques...\n"
		label=Fenetre::creerLabelType(texte)
		label.style_context.add_class("label_regles")

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
        Fenetre::box.add(label)
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
		Fenetre::css(:chemin => "/assets/css/FenetreRegles.css")
		return self
	end

end
