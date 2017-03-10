# 	Fichier contenant la fenetre exposant les statistiques
# 	
# 	Author:: 		PAVARD Valentin, DanAurea
# 	Developers: 	PAVARD Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreStatistiques < View

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
        event_box=Gtk::EventBox.new.add(Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}", 15, "#FF0000"))
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }
    	Fenetre::table.attach(event_box,7,10,0,1)
    	Fenetre::table.attach(Fenetre::creerLabelType("<u>Statistiques</u>", 40, "#000000"),0,10,1,2)

    	#niveau du user
    	Fenetre::table.attach(Fenetre::creerLabelType("Niveau #{@niveau}", 20, "#FF0000"),0,10,2,4)

    	#tableau statistique
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
        boutonRetour=Gtk::Button.new(:label => "Retour")
        boutonRetour.signal_connect('clicked'){
            Fenetre::fenetrePrecedente()
        }

        boutonQuitter=Gtk::Button.new(:label => "Quitter")
        boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #attach des boutons
        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
    end

    ##
    ## @brief     Lance la construction du modèle
    ##            de la vue.
    ##            Méthode à définir dans tout les cas !
    ##            Autrement pas de rendu de la page.
    ##
    ## @return     itself
    ##
	def run()
		self.miseEnPlace()
		return self
	end

end
