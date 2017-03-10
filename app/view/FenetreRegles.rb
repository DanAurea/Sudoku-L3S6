# 	Fichier contenant les règles de base dans le jeu
# 	
# 	Author:: 		PAVARD Valentin, DanAurea
# 	Developers: 	PAVARD Valentin, DanAurea
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
		#titre et pseudo
    	Fenetre::table.attach(Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}", 15, "#FF0000"),7,10,0,1)
    	Fenetre::table.attach(Fenetre::creerLabelType("<u>Règles</u>", 40, "#FFFFFF"),0,10,1,2)

    	#regles enoncées
        texte="<span font_desc=\"Comic sans MS 13\" foreground=\"#FFFFFF\">
        - Un sudoku classique contient 9 lignes et 9 colonnes, soit 81 cases au total.\n
        - Le but du jeu est de remplir ces cases avec des chiffres allant de 1 à 9 en veillant\n
        toujours à ce qu'un même chiffre ne figure qu'une seule fois par colonne, une seule \n 
        fois par ligne et une seule fois par carré de 9 cases(appelé région).\n
        - Au début du jeu, une vingtaine de chiffres sont déjà placés et il vous reste à trouver les autres.\n
        En effet, une grille initiale de sudoku corresctement constituée ne peut aboutir qu'à\n 
        une et une seule solution. Pour trouver les chiffres manquants, tout est une question\n 
        de logique et d'observation.\n
        - Suivez le tutoriel pour vous faciliter la tache et apprendre certaines techniques...\n
        </span>\n"
        
        label=Gtk::Label.new()
        label.set_markup(texte)
        label.set_justify(Gtk::JUSTIFY_LEFT)

        #Creation des Boutons
        boutonRetour=Gtk::Button.new(Gtk::Stock::GO_BACK)
        boutonRetour.signal_connect('clicked'){
        	Fenetre::fenetrePrecedente()
        }

        boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
        boutonQuitter.signal_connect('clicked'){
        	Fenetre::detruire()
        }

        #attach des boutons et du fond d'ecran
        Fenetre::table.attach(label,0,10,2,12)
        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
        Fenetre::table.attach(Fenetre::creerFondEcran(900,500),0,10,0,12)
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
		return self
	end

end
