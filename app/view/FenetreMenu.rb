
##
## @brief     Squelette du menu
##
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

    	Fenetre::table.attach(Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}", 15, "#FF0000"),7,10,0,1)
    	Fenetre::table.attach(Fenetre::creerLabelType("Menu Principal", 40, "#FFFFFF"),0,10,1,2)

        #Creation des Boutons
        boutonCharger=Gtk::Button.new("Reprendre une partie")
        
        boutonCharger.signal_connect('clicked'){
           Core::changeTo("Charger", "pseudo": @pseudo)
        }

        boutonNouveau=Gtk::Button.new("Nouvelle partie")
        boutonNouveau.signal_connect('clicked'){
            Core::changeTo("NouvellePartie", "pseudo": @pseudo)
        }

        boutonStat=Gtk::Button.new("Statistiques")
        boutonStat.signal_connect('clicked'){
            Core::changeTo("Statistiques", "pseudo": @pseudo)
        }

        boutonScore=Gtk::Button.new("Meilleurs scores")
        boutonScore.signal_connect('clicked'){
            Core::changeTo("Scores", "pseudo": @pseudo)
        }

        boutonReglage=Gtk::Button.new("Réglages")
        boutonReglage.signal_connect('clicked'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        boutonRegle=Gtk::Button.new("Règles de base")
        boutonRegle.signal_connect('clicked'){
            Core::changeTo("Regles", "pseudo": @pseudo)
        }

        boutonAPropos=Gtk::Button.new(Gtk::Stock::INFO)
        boutonAPropos.signal_connect('clicked'){
            # #Fenetre a propos
            # aPropos=FenetreAPropos.creer()
            # aPropos.afficher()
        }

        boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
        boutonQuitter.signal_connect('clicked'){
        	Fenetre::detruire()
        }

        Fenetre::table.attach(boutonCharger,3,7,3,4)
        Fenetre::table.attach(boutonNouveau,3,7,4,5)
        Fenetre::table.attach(boutonStat,3,7,5,6)
        Fenetre::table.attach(boutonScore,3,7,6,7)
        Fenetre::table.attach(boutonReglage,3,7,7,8)
        Fenetre::table.attach(boutonRegle,3,7,8,9)

        3.upto(8){|i| Fenetre::table.set_row_spacing(i, 5)}

        Fenetre::table.attach(boutonAPropos,1,3,10,11)
        Fenetre::table.attach(boutonQuitter,7,9,10,11)
        Fenetre::table.attach(Fenetre::creerFondEcran(900,500),0,10,0,12)

    end

	def run
		self.miseEnPlace()
		return self
	end
end