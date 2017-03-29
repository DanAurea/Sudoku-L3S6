# 	Fichier contenant la fenetre exposant les statistiques
# 	
# 	Author:: 		Valentin, DanAurea
# 	Developers: 	Valentin, DanAurea
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
    	   
    	#boxau statistique
    	Fenetre::box.add(labelNiveau)
    	Fenetre::box.add(labelDifficulte)
    	Fenetre::box.add(labelRecord)
    	Fenetre::box.add(labelMoyenne)
    	Fenetre::box.add(labelNbPartie)

    	Fenetre::box.add(labelFacile)
    	Fenetre::box.add(labelScore1)
    	Fenetre::box.add(labelScore1_1)
    	Fenetre::box.add(labelScore1_2)

    	Fenetre::box.add(labelMoyen)
    	Fenetre::box.add(labelScore2)
    	Fenetre::box.add(labelScore2_1)
    	Fenetre::box.add(labelScore2_2)

    	Fenetre::box.add(labelDifficile)
    	Fenetre::box.add(labelScore3)
    	Fenetre::box.add(labelScore3_1)
    	Fenetre::box.add(labelScore3_2)


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
        Fenetre::box.add(titre)
        Fenetre::box.add(event_box)
        Fenetre::box.add(boutonRetour)
        Fenetre::box.add(boutonQuitter)
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
