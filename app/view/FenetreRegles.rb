# => Contient la classe FenetreRegles qui propose un texte explicatif des règles de base
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreRegles
##
class FenetreRegles < View
    # VI box
    @boxTop
    @boxBottom
    # VI label
    @titreLabel
    @regle0Label
    @regle1Label
    # VI règles
    @tabRegle

    ##
    ## Initialize
    ##
    def initialize()
        # VI box
        @boxTop = Gtk::Box.new(:vertical,0)
        @boxBottom = Fenetre::creerBoxBottom()
        # VI label
        @titreLabel = Fenetre::creerLabelType("<span font_desc=\"#{Fenetre::SIZE_TITRE}\"><u>Règles</u></span>")
        @regle0Label = Fenetre::creerLabelType("<span font_desc=\"#{Fenetre::SIZE_TITRE_REGLE}\">*************************************************************</span>")
        @regle1Label = Fenetre::creerLabelType("<span font_desc=\"#{Fenetre::SIZE_TITRE_REGLE}\">*************************************************************</span>")
        # VI règles
        @tabRegle = [
            "     - Un sudoku classique contient 9 lignes et 9 colonnes,",
            "soit 81 cases au total.",
            "     - Le but du jeu est de remplir ces cases avec des chiffres",
            "allant de 1 à 9 en veillant toujours à ce qu'un même chiffre",
            "ne figure qu'une seule fois par colonne, une seule fois par",
            "ligne et une seule fois par carré de 9 cases (appelé région).",
            "     - Au début du jeu, une vingtaine de chiffres sont déjà placés",
            "et il vous reste à  trouver les autres. En effet, une grille",
            "initiale de sudoku correctement constituée ne peut aboutir qu'à",
            "une et une seule solution. Pour trouver les chiffres manquants,",
            "tout est une question de logique et d'observation.",
            "     - Suivez le tutoriel pour vous faciliter la tache et",
            "apprendre certaines techniques..."
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
    ## Créer la box verticale contenant le texte explicatif et le titre
    ##
    ##
    def creerBoxTop()
        #regles enoncées
        table=Gtk::Table.new(1,15,false)
        table.attach(@regle0Label,0,1,0,1)
        table.attach(@regle1Label,0,1,14,15)

        @tabRegle.each_with_index{|tab,index|
            id=index+1
            regleLabel=Fenetre::creerLabelType("<span font_desc=\"#{Fenetre::SIZE_CONTENU_REGLE}\">#{tab}</span>")
            regleLabel.override_color(:normal, Fenetre::COULEUR_BLANC)
            regleLabel.set_margin_top(5)
            regleLabel.set_margin_left(10)
            regleLabel.halign = :start
            table.attach(regleLabel,0,1,id,id+1)
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
        @regle0Label.override_color(:normal, Fenetre::COULEUR_ORANGE)
        @regle1Label.override_color(:normal, Fenetre::COULEUR_ORANGE)
        @regle0Label.set_margin_top(10)
        @regle0Label.set_margin_bottom(5)
        @regle1Label.set_margin_top(10)
        @regle1Label.set_margin_bottom(5)   
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
