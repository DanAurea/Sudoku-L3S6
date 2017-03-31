# => Contient la classe FenetreStatistiques exposant les statistiques
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreStatistiques
##
class FenetreStatistiques < View
	# VI box
    @boxTop
    @boxBottom
    # VI bouton
  
    # VI label
    @titreLabel
    @pseudoLabel
    @titreLabel
    @pseudoLabel
    @labelNiveau
	@labelDifficulte
	@labelRecord
	@labelMoyenne
	@labelNbPartie
	@labelFacile
	@labelMoyen
	@labelDifficile
    # VI stat
    @tabStat
    @niveau

	##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
	def miseEnPlace()
		@tabStat=[
            [0,0,0],
            [0,0,0],
            [0,0,0]
        ]
        @niveau=99
        creerBoxTop()
        @boxBottom=Fenetre::creerBoxBottom()
        ajoutCss()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

	##
    ## Créer la box verticale contenant le listing des stats et le titre
    ##
    ##
    def creerBoxTop()
		#labels
		@titreLabel = Fenetre::creerLabelType("<u>Statistiques</u>")
		@pseudoLabel = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
		@pseudoLabel.halign = :end
    	@labelNiveau = Fenetre::creerLabelType("<u>Niveau:</u> #{@niveau}")
    	@labelDifficulte = Fenetre::creerLabelType("<u>Difficulté</u>")
    	@labelRecord = Fenetre::creerLabelType("<u>Record</u>")
    	@labelMoyenne = Fenetre::creerLabelType("<u>Moyenne</u>")
    	@labelNbPartie = Fenetre::creerLabelType("<u>Nb Parties</u>")
    	@labelFacile = Fenetre::creerLabelType("Facile")
    	@labelMoyen = Fenetre::creerLabelType("Moyen")
    	@labelDifficile = Fenetre::creerLabelType("Difficile")
		
    	#tableau statistique
    	table=Gtk::Table.new(4,4,false)
    	table.attach(@labelDifficulte,0,1,0,1)
    	table.attach(@labelRecord,1,2,0,1)
    	table.attach(@labelMoyenne,2,3,0,1)
    	table.attach(@labelNbPartie,3,4,0,1)
    	table.attach(@labelFacile,0,1,1,2)
    	table.attach(@labelMoyen,0,1,2,3)
    	table.attach(@labelDifficile,0,1,3,4)

    	@tabStat.each_with_index{|tab,index|
    		tab.each_with_index{|valeur,id|
    			infoStat=Fenetre::creerLabelType("#{valeur}")
	            if index==0
	            	infoStat.style_context.add_class("label_contenu_stat_f")
	            elsif index==1
	            	infoStat.style_context.add_class("label_contenu_stat_m")
	            else
	            	infoStat.style_context.add_class("label_contenu_stat_d")
	            end
	            table.attach(infoStat,id+1,id+2,index+1,index+2)
	        }
        }

		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(@pseudoLabel)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        #add des boutons à la box
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(@titreLabel)
        @boxTop.add(@labelNiveau)
        @boxTop.add(table)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.style_context.add_class("titre_menu")
        @pseudoLabel.style_context.add_class("pseudo_menu")
        @labelNiveau.style_context.add_class("label_niveau")		
		@labelDifficulte.style_context.add_class("label_titre_stat")		
		@labelRecord.style_context.add_class("label_titre_stat")		
		@labelMoyenne.style_context.add_class("label_titre_stat")		
		@labelNbPartie.style_context.add_class("label_titre_stat")
		@labelFacile.style_context.add_class("label_contenu_stat_f")
		@labelMoyen.style_context.add_class("label_contenu_stat_m")
		@labelDifficile.style_context.add_class("label_contenu_stat_d")
    end

    ##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
	def run()
		self.miseEnPlace()
		Fenetre::css(:chemin => "/assets/css/FenetreStatistiques.css")
		return self
	end
end
