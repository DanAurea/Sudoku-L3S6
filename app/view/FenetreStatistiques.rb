# 	File description
# 	
# 	Author:: 		DanAurea
# 	Developers: 	DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class description
#
class FenetreStatistiques < View

	def initialize()
		
	end

	def miseEnPlace()
    	Fenetre::table.attach(Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}", 15, "#FF0000"),7,10,0,1)
    	Fenetre::table.attach(Fenetre::creerLabelType("<u>Statistiques</u>", 40, "#FFFFFF"),0,10,1,2)

    	Fenetre::table.attach(Fenetre::creerLabelType("Niveau #{@niveau}", 20, "#FF0000"),0,10,2,4)

    	Fenetre::table.attach(Fenetre::creerLabelType("Difficulté", 18, "#FFFFFF"),0,3,4,6)
    	Fenetre::table.attach(Fenetre::creerLabelType("Record", 18, "#FFFFFF"),3,5,4,6)
    	Fenetre::table.attach(Fenetre::creerLabelType("Moyenne", 18, "#FFFFFF"),5,7,4,6)
    	Fenetre::table.attach(Fenetre::creerLabelType("Nb Parties", 18, "#FFFFFF"),7,10,4,6)
    	
    	Fenetre::table.attach(Fenetre::creerLabelType("Facile", 15, "#000000"),0,3,6,7)
    	Fenetre::table.attach(Fenetre::creerLabelType("---", 15, "#000000"),3,5,6,7)
    	Fenetre::table.attach(Fenetre::creerLabelType("---", 15, "#000000"),5,7,6,7)
    	Fenetre::table.attach(Fenetre::creerLabelType("0", 15, "#000000"),7,10,6,7)

    	Fenetre::table.attach(Fenetre::creerLabelType("Moyen", 15, "#000000"),0,3,7,8)
    	Fenetre::table.attach(Fenetre::creerLabelType("---", 15, "#000000"),3,5,7,8)
    	Fenetre::table.attach(Fenetre::creerLabelType("---", 15, "#000000"),5,7,7,8)
    	Fenetre::table.attach(Fenetre::creerLabelType("0", 15, "#000000"),7,10,7,8)

    	Fenetre::table.attach(Fenetre::creerLabelType("Difficile", 15, "#000000"),0,3,8,9)
    	Fenetre::table.attach(Fenetre::creerLabelType("---", 15, "#000000"),3,5,8,9)
    	Fenetre::table.attach(Fenetre::creerLabelType("---", 15, "#000000"),5,7,8,9)
    	Fenetre::table.attach(Fenetre::creerLabelType("0", 15, "#000000"),7,10,8,9)


        #Creation des Boutons
        boutonRetour=Gtk::Button.new(Gtk::Stock::GO_BACK)
        boutonRetour.signal_connect('clicked'){
        	Fenetre::fenetrePrecedente()
        }

        boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
        boutonQuitter.signal_connect('clicked'){
        	Fenetre::detruire()
        }

        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
        Fenetre::table.attach(Fenetre::creerFondEcran(900,500),0,10,0,12)
    end

	def run()
		self.miseEnPlace()
		return self
	end

end