# 	Fichier contenant la fenetre exposant les statistiques
# 	
# 	Author:: 		Valentin, DanAurea
# 	Developers: 	Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreStatistiques < View

	@boxTop
    @boxBottom

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
        creerBoxTop()
        creerBoxBottom()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

	##
    #Creer la box vertical contenant les boutons des niveaux et le titre
    def creerBoxTop()
		## Définis les classes des labels
		#titre
		titre = Fenetre::creerLabelType("<u>Statistiques</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")
		pseudo.halign = :end
		#niveau
    	labelNiveau = Fenetre::creerLabelType("<u>Niveau:</u> 0")
		labelNiveau.style_context.add_class("label_niveau")
		#difficulte
		labelDifficulte = Fenetre::creerLabelType("<u>Difficulté</u>")
		labelDifficulte.style_context.add_class("label_titre_stat")
		#record
		labelRecord = Fenetre::creerLabelType("<u>Record</u>")
		labelRecord.style_context.add_class("label_titre_stat")
		#moyenne
		labelMoyenne = Fenetre::creerLabelType("<u>Moyenne</u>")
		labelMoyenne.style_context.add_class("label_titre_stat")
		#nb partie
		labelNbPartie = Fenetre::creerLabelType("<u>Nb Parties</u>")
		labelNbPartie.style_context.add_class("label_titre_stat")
		#Facile
		labelFacile = Fenetre::creerLabelType("Facile")
		labelFacile.style_context.add_class("label_contenu_stat_f")
		#score1
		labelScore1 = Fenetre::creerLabelType("---")
		labelScore1.style_context.add_class("label_contenu_stat_f")
		#score1_1
		labelScore1_1 = Fenetre::creerLabelType("---")
		labelScore1_1.style_context.add_class("label_contenu_stat_f")
		#score1_2
		labelScore1_2 = Fenetre::creerLabelType("0")
		labelScore1_2.style_context.add_class("label_contenu_stat_f")
		#moyen
		labelMoyen = Fenetre::creerLabelType("Moyen")
		labelMoyen.style_context.add_class("label_contenu_stat_m")
		#score2
		labelScore2 = Fenetre::creerLabelType("---")
		labelScore2.style_context.add_class("label_contenu_stat_m")
		#score2_1
		labelScore2_1 = Fenetre::creerLabelType("---")
		labelScore2_1.style_context.add_class("label_contenu_stat_m")
		#score2_2
		labelScore2_2 = Fenetre::creerLabelType("0")
		labelScore2_2.style_context.add_class("label_contenu_stat_m")
		#difficile
		labelDifficile = Fenetre::creerLabelType("Difficile")
		labelDifficile.style_context.add_class("label_contenu_stat_d")
		#score3
		labelScore3 = Fenetre::creerLabelType("---")
		labelScore3.style_context.add_class("label_contenu_stat_d")
		#score-3_1
		labelScore3_1 = Fenetre::creerLabelType("---")
		labelScore3_1.style_context.add_class("label_contenu_stat_d")
		#score3_2
		labelScore3_2 = Fenetre::creerLabelType("0")
		labelScore3_2.style_context.add_class("label_contenu_stat_d")


		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }
    	   
    	#tableau statistique
    	table=Gtk::Table.new(4,4,false)
    	table.attach(labelDifficulte,0,1,0,1)
    	table.attach(labelRecord,1,2,0,1)
    	table.attach(labelMoyenne,2,3,0,1)
    	table.attach(labelNbPartie,3,4,0,1)

    	table.attach(labelFacile,0,1,1,2)
    	table.attach(labelScore1,1,2,1,2)
    	table.attach(labelScore1_1,2,3,1,2)
    	table.attach(labelScore1_2,3,4,1,2)

    	table.attach(labelMoyen,0,1,2,3)
    	table.attach(labelScore2,1,2,2,3)
    	table.attach(labelScore2_1,2,3,2,3)
    	table.attach(labelScore2_2,3,4,2,3)

    	table.attach(labelDifficile,0,1,3,4)
    	table.attach(labelScore3,1,2,3,4)
    	table.attach(labelScore3_1,2,3,3,4)
		table.attach(labelScore3_2,3,4,3,4)

        #add des boutons
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(titre)
        @boxTop.add(labelNiveau)
        @boxTop.add(table)
    end

    ##
    #Creer la box horizontal contenant les boutons retour et quitter
    def creerBoxBottom()
        #Creation des Boutons
        boutonRetour=Gtk::Button.new(:label => "Retour")
        boutonRetour.style_context.add_class("bouton_bottom")
        boutonRetour.signal_connect('clicked'){
            Core::back()
        }

        boutonQuitter=Gtk::Button.new(:label => "Quitter")
        boutonQuitter.style_context.add_class("bouton_bottom")
        boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #add des boutons
        @boxBottom=Gtk::Box.new(:horizontal, 0)
        @boxBottom.halign = :center
        @boxBottom.add(boutonRetour)
        @boxBottom.add(boutonQuitter)
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
