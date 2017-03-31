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
        @titreLabel = Fenetre::creerLabelType("<u>Meilleurs Scores</u>")
        @labelPosition = Fenetre::creerLabelType("<u>Position</u>")
        @labelNom = Fenetre::creerLabelType("<u>Personne</u>")
        @labelPoint = Fenetre::creerLabelType("<u>Points</u>")
        # VI tableau de score
        @tabScore = [
            ["Monsieur X","??"],
            ["Monsieur X","??"],
            ["Monsieur X","??"],
            ["Monsieur X","??"],
            ["Monsieur X","??"],
            ["Monsieur X","??"],
            ["Monsieur X","??"],
            ["Monsieur X","??"],
            ["Monsieur X","??"],
            ["Monsieur X","??"]
        ]
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

        @tabScore.each_with_index{|tab,index|
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

        #add des boutons à la box
        @boxTop.add(@titreLabel)
        @boxTop.add(tableScore)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.style_context.add_class("titre_menu")
        @labelPosition.style_context.add_class("label_titre_score")
        @labelNom.style_context.add_class("label_titre_score")
        @labelPoint.style_context.add_class("label_titre_score")
    end

    ##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
	def run()
		self.miseEnPlace()
		Fenetre::css(:chemin => "/assets/css/FenetreScores.css")
		return self
	end
end
