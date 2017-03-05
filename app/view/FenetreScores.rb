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
class FenetreScores < View

	def initialize()
		
	end

	def miseEnPlace()
    	Fenetre::table.attach(Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}", 15, "#FF0000"),7,10,0,1)
    	Fenetre::table.attach(Fenetre::creerLabelType("<u>Meilleurs Scores</u>", 40, "#FFFFFF"),0,10,1,2)

    	tabScore=[["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"]]
        
        #Conteneur table
        tableScore=Gtk::Table.new(10,10,false)

        #Creation des Boutons
        tabScore.each_with_index{|tab,index|
        	texte="<span font_desc=\"Comic sans MS 17\" foreground=\"#FF0000\"> #{index+1} => #{tab[0]} avec  #{tab[1]} points </span>\n"
        	label=Gtk::Label.new()
        	label.set_markup(texte)
        	label.set_justify(Gtk::JUSTIFY_CENTER)
        	tableScore.attach(label,0,10,index,index+1)
        }

        boutonRetour=Gtk::Button.new(Gtk::Stock::GO_BACK)
        boutonRetour.signal_connect('clicked'){
        	Fenetre::fenetrePrecedente()
        }

        boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
        boutonQuitter.signal_connect('clicked'){
        	Fenetre::detruire()
        }

        Fenetre::table.attach(tableScore,3,7,2,11)
        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
        Fenetre::table.attach(Fenetre::creerFondEcran(900,500),0,10,0,12)
    end

	def run()
		self.miseEnPlace()
		return self
	end

end