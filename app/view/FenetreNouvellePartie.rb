
# 	File description
# 	
# 	Author:: 		Valentin Pavard, DanAurea
# 	Developers: 	Valentin Pavard, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class description
#
class FenetreNouvellePartie < View

	def initialize()
		
	end

	def miseEnPlace()
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

        Fenetre::table.attach(boutonApprentissage,3,7,5,6)
        Fenetre::table.attach(boutonJeuLibre,3,7,7,8)
        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
        Fenetre::table.attach(Fenetre::creerFondEcran(900,500),0,10,0,12)
    end

	def run()
		self.miseEnPlace
		return self
	end

end