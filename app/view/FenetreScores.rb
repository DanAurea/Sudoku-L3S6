# 	Fichier contenant l'affichage des meilleurs scores du jeu
# 	
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	

class FenetreScores < View

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
        @boxBottom=Fenetre::creerBoxBottom()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

    ##
    #Creer la box vertical contenant les boutons des niveaux et le titre
    def creerBoxTop()
        tabScore=[["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"],["Monsieur X","??"]]

        ## Définis les classes des labels
		#titre
		titre = Fenetre::creerLabelType("<u>Meilleurs Scores</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")
        pseudo.halign = :end
        #position
        labelPosition = Fenetre::creerLabelType("<u>Position</u>")
        labelPosition.style_context.add_class("label_titre_score")
        #nom
        labelNom = Fenetre::creerLabelType("<u>Personne</u>")
        labelNom.style_context.add_class("label_titre_score")
        #point
        labelPoint = Fenetre::creerLabelType("<u>Points</u>")
        labelPoint.style_context.add_class("label_titre_score")

		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        #Conteneur box
        tableScore=Gtk::Table.new(3,11,false)
        tableScore.attach(labelPosition,0,1,0,1)
        tableScore.attach(labelNom,1,2,0,1)
        tableScore.attach(labelPoint,2,3,0,1)

        tabScore.each_with_index{|tab,index|
            id=index+1
            pos=Fenetre::creerLabelType("#{id}")
            pos.style_context.add_class("ligne_score")
            nom=Fenetre::creerLabelType("#{tab[0]}")
            nom.style_context.add_class("ligne_score")
            pts=Fenetre::creerLabelType("#{tab[1]}")
            pts.style_context.add_class("ligne_score")
            tableScore.attach(pos,0,1,id,id+1)
            tableScore.attach(nom,1,2,id,id+1)
            tableScore.attach(pts,2,3,id,id+1)
        }

        #add des boutons
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(titre)
        @boxTop.add(tableScore)
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
