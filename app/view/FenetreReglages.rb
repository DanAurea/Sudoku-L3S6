# => Contient la classe FenetreReglages  contenant la gestion des reglages(taille, couleur)
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreReglages
##
class FenetreReglages < View
    # VI box
    @boxTop
    @boxBottom
    # VI bouton
    @boutonCouleurCaseBase
    @boutonCouleurCaseSelectionne
    @boutonCouleurTexte
    @boutonCouleurIndices
    @boutonPolice
    # VI label
    @titreLabel
    @pseudoLabel
    @tmp
    @labelCouleurCaseBase
    @labelCouleurCaseSelectionne
    @labelCouleurTexte
    @labelCouleurIndices
    @labelPolice

    ##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
    def miseEnPlace()        
        creerBoxTop()
        @boxBottom=Fenetre::creerBoxBottom()
        ajoutCss()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

    ##
    ## Créer la box verticale contenant le listing des réglages et le titre
    ##
    ##
    def creerBoxTop()
        #labels
        @titreLabel = Fenetre::creerLabelType("<u>Réglages</u>")
        @pseudoLabel = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
        @pseudoLabel.halign = :end
        @tmp = Fenetre::creerLabelType("  ")
        @labelCouleurCaseBase = Fenetre::creerLabelType("Couleur des cases de base:")
        @labelCouleurCaseBase.halign = :start
        @labelCouleurCaseSelectionne = Fenetre::creerLabelType("Couleur des cases surlignées:")
        @labelCouleurCaseSelectionne.halign = :start
        @labelCouleurTexte = Fenetre::creerLabelType("Couleur du texte:")
        @labelCouleurTexte.halign = :start
        @labelCouleurIndices = Fenetre::creerLabelType("Couleur des indices:") 
        @labelCouleurIndices.halign = :start
        @labelPolice = Fenetre::creerLabelType("Police de texte:")
        @labelPolice.halign = :start

        #Creation des Boutons
        event_box=Gtk::EventBox.new.add(@pseudoLabel)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        @boutonCouleurCaseBase = Gtk::ColorButton.new()
        @boutonCouleurCaseSelectionne = Gtk::ColorButton.new()
        @boutonCouleurTexte = Gtk::ColorButton.new()
        @boutonCouleurIndices = Gtk::ColorButton.new()
        @boutonPolice = Gtk::FontButton.new()

        #tableau réglages
        table=Gtk::Table.new(2,5,false)
        table.attach(@labelCouleurCaseBase,0,1,0,1)
        table.attach(@boutonCouleurCaseBase,1,2,0,1)
        table.attach(@labelCouleurCaseSelectionne,0,1,1,2)
        table.attach(@boutonCouleurCaseSelectionne,1,2,1,2)
        table.attach(@labelCouleurTexte,0,1,2,3)
        table.attach(@boutonCouleurTexte,1,2,2,3)
        table.attach(@labelCouleurIndices,0,1,3,4)
        table.attach(@boutonCouleurIndices,1,2,3,4)
        table.attach(@labelPolice,0,1,4,5)
        table.attach(@boutonPolice,1,2,4,5)

        #add des boutons
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(@titreLabel)
        @boxTop.add(@tmp)
        @boxTop.add(table)

        self.paramCouleurPolice
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.style_context.add_class("titre_menu")
        @pseudoLabel.style_context.add_class("pseudo_menu")
        @tmp.style_context.add_class("label_reglage_f")        
        @labelCouleurCaseBase.style_context.add_class("label_reglage")
        @labelCouleurCaseSelectionne.style_context.add_class("label_reglage")
        @labelCouleurTexte.style_context.add_class("label_reglage")
        @labelCouleurIndices.style_context.add_class("label_reglage")
        @labelPolice.style_context.add_class("label_reglage")
        #css bouton
        @boutonCouleurCaseBase.style_context.add_class("bouton_reglage")
        @boutonCouleurCaseSelectionne.style_context.add_class("bouton_reglage")
        @boutonCouleurTexte.style_context.add_class("bouton_reglage")
        @boutonCouleurIndices.style_context.add_class("bouton_reglage")
        @boutonPolice.style_context.add_class("bouton_reglage")
    end

    ##
    ## Définis les paramètres d'apparence de l'utilisateur pour les réglages
    ##
    ## @return self
    ##
    def paramCouleurPolice()
        config = Hash.new()

        @boutonCouleurCaseBase.signal_connect "color-set" do
            config["caseBase"]=@boutonCouleurCaseBase.color
        end

        @boutonCouleurCaseSelectionne.signal_connect "color-set" do
            config["caseSelectionne"]=@boutonCouleurCaseSelectionne.color
        end

        @boutonCouleurTexte.signal_connect "color-set" do
            config["couleurTexte"]=@boutonCouleurTexte.color
        end

        @boutonCouleurIndices.signal_connect "color-set" do
            config["couleurIndices"]=@boutonCouleurIndices.color
        end

        @boutonPolice.signal_connect "font-set" do
            font = @boutonPolice.font_name
            config["taillePolice"]=font.slice!(-2,2)
            config["police"]=font
        end

        return self
    end

    ##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
    def run()
        self.miseEnPlace()
        Fenetre::css(:chemin => "/assets/css/FenetreReglages.css")
        return self
    end
end
