# 	Fichier contenant l'affichage des meilleurs scores du jeu
# 	
# 	Author:: 		PAVARD Valentin, DanAurea
# 	Developers: 	PAVARD Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 
class FenetreScores < View

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
		titre = Fenetre::creerLabelType("<u>Meilleurs Scores</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")

		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        #Conteneur table
        tabScore=[["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"]]
        tableScore=Gtk::Table.new(10,10,false)
        tabScore.each_with_index{|tab,index|
       		ligneScore = Fenetre::creerLabelType("#{index+1} => #{tab[0]} avec  #{tab[1]} points")
			ligneScore.style_context.add_class("ligne_score")
        	tableScore.attach(ligneScore,0,10,index,index+1)
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
        Fenetre::table.attach(titre,0,10,1,2)
        Fenetre::table.attach(event_box,7,10,0,1)
        Fenetre::table.attach(tableScore,3,7,2,11)
        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
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
		Fenetre::css(:chemin => "/assets/css/FenetreScores.css")
		return self
	end

end
