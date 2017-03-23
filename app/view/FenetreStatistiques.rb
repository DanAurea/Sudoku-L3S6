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
		## Définis les classes de titres
		#titre
		titre = Fenetre::creerLabelType("<u>Statistiques</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")
		#niveau
    	labelNiveau = Fenetre::creerLabelType("Niveau #{@niveau}")
		labelNiveau.style_context.add_class("label_niveau")
		#difficulte
		labelDifficulte = Fenetre::creerLabelType("Difficulté")
		labelDifficulte.style_context.add_class("label_titre_stat")
		#record
		labelRecord = Fenetre::creerLabelType("Record")
		labelRecord.style_context.add_class("label_titre_stat")
		#moyenne
		labelMoyenne = Fenetre::creerLabelType("Moyenne")
		labelMoyenne.style_context.add_class("label_titre_stat")
		#nb partie
		labelNbPartie = Fenetre::creerLabelType("Nb Parties")
		labelNbPartie.style_context.add_class("label_titre_stat")
		#Facile
		labelFacile = Fenetre::creerLabelType("Facile")
		labelFacile.style_context.add_class("label_contenu_stat")
		#score1
		labelScore1 = Fenetre::creerLabelType("---")
		labelScore1.style_context.add_class("label_contenu_stat")
		#score1_1
		labelScore1_1 = Fenetre::creerLabelType("---")
		labelScore1_1.style_context.add_class("label_contenu_stat")
		#score1_2
		labelScore1_2 = Fenetre::creerLabelType("0")
		labelScore1_2.style_context.add_class("label_contenu_stat")
		#moyen
		labelMoyen = Fenetre::creerLabelType("Moyen")
		labelMoyen.style_context.add_class("label_contenu_stat")
		#score2
		labelScore2 = Fenetre::creerLabelType("---")
		labelScore2.style_context.add_class("label_contenu_stat")
		#score2_1
		labelScore2_1 = Fenetre::creerLabelType("---")
		labelScore2_1.style_context.add_class("label_contenu_stat")
		#score2_2
		labelScore2_2 = Fenetre::creerLabelType("0")
		labelScore2_2.style_context.add_class("label_contenu_stat")
		#difficile
		labelDifficile = Fenetre::creerLabelType("Difficile")
		labelDifficile.style_context.add_class("label_contenu_stat")
		#score3
		labelScore3 = Fenetre::creerLabelType("---")
		labelScore3.style_context.add_class("label_contenu_stat")
		#score-3_1
		labelScore3_1 = Fenetre::creerLabelType("---")
		labelScore3_1.style_context.add_class("label_contenu_stat")
		#score3_2
		labelScore3_2 = Fenetre::creerLabelType("0")
		labelScore3_2.style_context.add_class("label_contenu_stat")


		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }
    	   
    	#tableau statistique
    	Fenetre::table.attach(labelNiveau,0,10,2,4)
    	Fenetre::table.attach(labelDifficulte,0,3,4,6)
    	Fenetre::table.attach(labelRecord,3,5,4,6)
    	Fenetre::table.attach(labelMoyenne,5,7,4,6)
    	Fenetre::table.attach(labelNbPartie,7,10,4,6)

    	Fenetre::table.attach(labelFacile,0,3,6,7)
    	Fenetre::table.attach(labelScore1,3,5,6,7)
    	Fenetre::table.attach(labelScore1_1,5,7,6,7)
    	Fenetre::table.attach(labelScore1_2,7,10,6,7)

    	Fenetre::table.attach(labelMoyen,0,3,7,8)
    	Fenetre::table.attach(labelScore2,3,5,7,8)
    	Fenetre::table.attach(labelScore2_1,5,7,7,8)
    	Fenetre::table.attach(labelScore2_2,7,10,7,8)

    	Fenetre::table.attach(labelDifficile,0,3,8,9)
    	Fenetre::table.attach(labelScore3,3,5,8,9)
    	Fenetre::table.attach(labelScore3_1,5,7,8,9)
    	Fenetre::table.attach(labelScore3_2,7,10,8,9)


        #Creation des Boutons
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
		Fenetre::css(:chemin => "/assets/css/FenetreStatistiques.css")
		return self
	end

end
