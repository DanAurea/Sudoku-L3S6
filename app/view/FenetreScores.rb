# => Contient la classe FenetreScores contenant l'affichage des meilleurs scores du jeu
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreScores
##
class FenetreScores < View
    # VI box
    @boxTop
    @boxBottom  
    # VI label
    @titreLabel
    @labelPosition
    @labelNom
    @labelPoint
    # VI tableau de score
    @tabScore

    ##
    ## Initialize
    ##
    def initialize()
        # VI box
        @boxTop = Gtk::Box.new(:vertical,0)
        @boxBottom = Fenetre::creerBoxBottom()
        # VI label
        @titreLabel = Fenetre::creerLabelType("<u>Meilleurs Scores</u>", Fenetre::SIZE_TITRE)
        @labelPosition = Fenetre::creerLabelType("<u>Position</u>", Fenetre::SIZE_TITRE_SCORE)
        @labelNom = Fenetre::creerLabelType("<u>Personne</u>", Fenetre::SIZE_TITRE_SCORE)
        @labelPoint = Fenetre::creerLabelType("<u>Points</u>", Fenetre::SIZE_TITRE_SCORE)
        # VI tableau de score
        @tabScore = []
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
    ## Créer la box verticale contenant le listing des scores et le titre
    ##
    ##
    def creerBoxTop()
		#Action des boutons
        #Conteneur box
        tableScore=Gtk::Table.new(3,11,false)
        tableScore.attach(@labelPosition,0,1,0,1)
        tableScore.attach(@labelNom,1,2,0,1)
        tableScore.attach(@labelPoint,2,3,0,1)

        @tabScore = @meilleursScores

        @tabScore.each_with_index{|tab,index|
            id=index+1
            pos=Fenetre::creerLabelType("#{id}", Fenetre::SIZE_CONTENU_SCORE)
            pos.override_color(:normal, Fenetre::COULEUR_BLANC)
            pos.set_margin_top(10)
            nom=Fenetre::creerLabelType("#{tab[0]}", Fenetre::SIZE_CONTENU_SCORE)
            nom.override_color(:normal, Fenetre::COULEUR_BLANC)
            nom.set_margin_top(10)
            pts=Fenetre::creerLabelType("#{tab[1]}", Fenetre::SIZE_CONTENU_SCORE)
            pts.override_color(:normal, Fenetre::COULEUR_BLANC)
            pts.set_margin_top(10)
            tableScore.attach(pos,0,1,id,id+1)
            tableScore.attach(nom,1,2,id,id+1)
            tableScore.attach(pts,2,3,id,id+1)
        }

        #add des boutons à la box
        @boxTop.add(@titreLabel)
        @boxTop.add(tableScore)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.override_color(:normal, Fenetre::COULEUR_BLANC)
        @titreLabel.set_margin_top(30)
        @labelPosition.override_color(:normal, Fenetre::COULEUR_ORANGE)
        @labelPosition.set_margin(30)
        @labelPosition.set_margin_bottom(10)
        @labelNom.override_color(:normal, Fenetre::COULEUR_ORANGE)
        @labelNom.set_margin(30)
        @labelNom.set_margin_bottom(10)
        @labelPoint.override_color(:normal, Fenetre::COULEUR_ORANGE)
        @labelPoint.set_margin(30)
        @labelPoint.set_margin_bottom(10)
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
