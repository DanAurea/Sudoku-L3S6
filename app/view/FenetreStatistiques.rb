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
    # VI label
    @titreLabel
	@labelDifficulte
	@labelRecord
	@labelMoyenne
	@labelNbPartie
	@labelFacile
	@labelMoyen
	@labelDifficile
    # VI stat
    @tabStat

    ##
    ## Initialize
    ##
    def initialize()
		# VI box
		@boxTop = Gtk::Box.new(:vertical,0)
		@boxBottom = Fenetre::creerBoxBottom()
		# VI label
		@titreLabel = Fenetre::creerLabelType("<u>Statistiques</u>",Fenetre::SIZE_TITRE)
    	@labelDifficulte = Fenetre::creerLabelType("<u>Difficulté</u>",Fenetre::SIZE_TITRE_STAT)
    	@labelRecord = Fenetre::creerLabelType("<u>Record</u>",Fenetre::SIZE_TITRE_STAT)
    	@labelMoyenne = Fenetre::creerLabelType("<u>Moyenne</u>",Fenetre::SIZE_TITRE_STAT)
    	@labelNbPartie = Fenetre::creerLabelType("<u>Nb Parties</u>",Fenetre::SIZE_TITRE_STAT)
    	@labelFacile = Fenetre::creerLabelType("Facile", Fenetre::SIZE_CONTENU_STAT)
    	@labelMoyen = Fenetre::creerLabelType("Moyen", Fenetre::SIZE_CONTENU_STAT)
    	@labelDifficile = Fenetre::creerLabelType("Difficile", Fenetre::SIZE_CONTENU_STAT)
		# VI stat

		@tabStat = []
  
    end

	##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
	def miseEnPlace()
		creerBoxTop()
		ajoutCss()
		Fenetre::box.add(@boxTop)
		Fenetre::box.add(@boxBottom)
	end

	##
    ## Créer la box verticale contenant le listing des stats et le titre
    ##
    ##
    def creerBoxTop()
		#Action des boutons
    	#tableau statistique
    	table=Gtk::Table.new(4,4,false)
    	table.attach(@labelDifficulte,0,1,0,1)
    	table.attach(@labelRecord,1,2,0,1)
    	table.attach(@labelMoyenne,2,3,0,1)
    	table.attach(@labelNbPartie,3,4,0,1)
    	table.attach(@labelFacile,0,1,1,2)
    	table.attach(@labelMoyen,0,1,2,3)
    	table.attach(@labelDifficile,0,1,3,4)

        @tabStat = [
            [@meilleursScores[Jeu::FACILE], @moyennes[Jeu::FACILE], @nombreParties[Jeu::FACILE]],
            [@meilleursScores[Jeu::MOYEN], @moyennes[Jeu::MOYEN], @nombreParties[Jeu::MOYEN]],
            [@meilleursScores[Jeu::DIFFICILE], @moyennes[Jeu::DIFFICILE], @nombreParties[Jeu::DIFFICILE]]
        ]

    	@tabStat.each_with_index{|tab,index|
    		tab.each_with_index{|valeur,id|
    			infoStat=Fenetre::creerLabelType("#{valeur}",Fenetre::SIZE_CONTENU_STAT)
    			if index==0
    				infoStat.override_color(:normal, Fenetre::COULEUR_VERT)
    			elsif index==1
    				infoStat.override_color(:normal, Fenetre::COULEUR_JAUNE)
    			else
    				infoStat.override_color(:normal, Fenetre::COULEUR_ROUGE)
    			end
                infoStat.set_margin(15)
    			table.attach(infoStat,id+1,id+2,index+1,index+2)
    		}
    	}

        #add des boutons à la box
        @boxTop.add(@titreLabel)
        @boxTop.add(table)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.override_color(:normal, Fenetre::COULEUR_BLANC)
        @titreLabel.set_margin_top(30)
		@labelDifficulte.override_color(:normal, Fenetre::COULEUR_BLANC)
        @labelDifficulte.set_margin(30)		
		@labelRecord.override_color(:normal, Fenetre::COULEUR_BLANC)	
        @labelRecord.set_margin(30)	
		@labelMoyenne.override_color(:normal, Fenetre::COULEUR_BLANC)	
        @labelMoyenne.set_margin(30)	
		@labelNbPartie.override_color(:normal, Fenetre::COULEUR_BLANC)
        @labelNbPartie.set_margin(30)
		@labelFacile.override_color(:normal, Fenetre::COULEUR_VERT)
        @labelFacile.set_margin(15)
		@labelMoyen.override_color(:normal, Fenetre::COULEUR_JAUNE)
        @labelMoyen.set_margin(15)
		@labelDifficile.override_color(:normal, Fenetre::COULEUR_ROUGE)
        @labelDifficile.set_margin(15)
    end

    ##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
	def run()
		self.miseEnPlace()
		return self
	end
end
