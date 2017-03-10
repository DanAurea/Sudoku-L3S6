# 	Fichier contenant la gestion de la nouvelle partie
# 	
# 	Author:: 		PAVARD Valentin, DanAurea
# 	Developers: 	PAVARD Valentin, DanAurea
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
		#titre et pseudo
    	Fenetre::table.attach(Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}", 15, "#FF0000"),7,10,0,1)
    	Fenetre::table.attach(Fenetre::creerLabelType("<u>Nouvelle partie</u>", 40, "#FFFFFF"),0,10,1,2)

        #Creation des Boutons
        boutonApprentissage=Gtk::Button.new("Apprentissage avec aides")
        boutonApprentissage.signal_connect('clicked'){
            Core::changeTo("Apprentissage", "pseudo": @pseudo)
        }

        boutonJeuLibre=Gtk::Button.new("Jeu libre")
        boutonJeuLibre.signal_connect('clicked'){
            Core::changeTo("JeuLibre", "pseudo": @pseudo)
        }

        boutonRetour=Gtk::Button.new(Gtk::Stock::GO_BACK)
        boutonRetour.signal_connect('clicked'){
        	Fenetre::fenetrePrecedente()
        }

        boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
        boutonQuitter.signal_connect('clicked'){
        	Fenetre::detruire()
        }

        #attach des boutons et du fond d'ecran
        Fenetre::table.attach(boutonApprentissage,3,7,5,6)
        Fenetre::table.attach(boutonJeuLibre,3,7,7,8)
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
		self.miseEnPlace
		return self
	end

end
