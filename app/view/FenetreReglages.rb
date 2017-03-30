#   Fichier contenant la gestion des reglages(taille, couleur)
#
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
#   Version::       0.1
#   Copyright::     © 2016
#   License::       Distributes under the same terms as Ruby
#

class FenetreReglages < View
    # VI
    @boutonCouleurCaseBase
    @boutonCouleurCaseSelectionne
    @boutonCouleurTexte
    @boutonCouleurIndices
    @boutonPolice
    @config

    @boxTop
    @boxBottom

    ##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
    def miseEnPlace()        
        creerBoxTop()
        @boxBottom=Fenetre::creerBoxBottom()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

    ##
    ## Créer la box verticale contenant le listing des réglages et le titre
    ##
    ##
    def creerBoxTop()
        ## Définis les classes des labels
        #titre
        titre = Fenetre::creerLabelType("<u>Réglages</u>")
        titre.style_context.add_class("titre_menu")
        #pseudo
        pseudo = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
        pseudo.style_context.add_class("pseudo_menu")
        pseudo.halign = :end
        #tmp
        tmp = Fenetre::creerLabelType("  ")
        tmp.style_context.add_class("label_reglage_f")
        #couleur case base
        labelCouleurCaseBase = Fenetre::creerLabelType("Couleur des cases de base:")
        labelCouleurCaseBase.style_context.add_class("label_reglage")
        labelCouleurCaseBase.halign = :start
        #couleur case surlignée
        labelCouleurCaseSelectionne = Fenetre::creerLabelType("Couleur des cases surlignées:")
        labelCouleurCaseSelectionne.style_context.add_class("label_reglage")
        labelCouleurCaseSelectionne.halign = :start
        #couleur texte
        labelCouleurTexte = Fenetre::creerLabelType("Couleur du texte:")
        labelCouleurTexte.style_context.add_class("label_reglage")
        labelCouleurTexte.halign = :start
        #couleur indice
        labelCouleurIndices = Fenetre::creerLabelType("Couleur des indices:")
        labelCouleurIndices.style_context.add_class("label_reglage")
        labelCouleurIndices.halign = :start
        #police de texte
        labelPolice = Fenetre::creerLabelType("Police de texte:")
        labelPolice.style_context.add_class("label_reglage")
        labelPolice.halign = :start

        #Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        @boutonCouleurCaseBase = Gtk::ColorButton.new()
        @boutonCouleurCaseBase.style_context.add_class("bouton_reglage")
        @boutonCouleurCaseSelectionne = Gtk::ColorButton.new()
        @boutonCouleurCaseSelectionne.style_context.add_class("bouton_reglage")
        @boutonCouleurTexte = Gtk::ColorButton.new()
        @boutonCouleurTexte.style_context.add_class("bouton_reglage")
        @boutonCouleurIndices = Gtk::ColorButton.new()
        @boutonCouleurIndices.style_context.add_class("bouton_reglage")
        @boutonPolice = Gtk::FontButton.new()
        @boutonPolice.style_context.add_class("bouton_reglage")

        #tableau réglages
        table=Gtk::Table.new(2,5,false)
        table.attach(labelCouleurCaseBase,0,1,0,1)
        table.attach(@boutonCouleurCaseBase,1,2,0,1)

        table.attach(labelCouleurCaseSelectionne,0,1,1,2)
        table.attach(@boutonCouleurCaseSelectionne,1,2,1,2)

        table.attach(labelCouleurTexte,0,1,2,3)
        table.attach(@boutonCouleurTexte,1,2,2,3)

        table.attach(labelCouleurIndices,0,1,3,4)
        table.attach(@boutonCouleurIndices,1,2,3,4)

        table.attach(labelPolice,0,1,4,5)
        table.attach(@boutonPolice,1,2,4,5)

        #add des boutons
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(titre)
        @boxTop.add(tmp)
        @boxTop.add(table)

        self.paramCouleurPolice
    end

    ##
    ## Définis les paramètres d'apparence de l'utilisateur pour les réglages
    ##
    ## @return self
    ##
    def paramCouleurPolice()
        @boutonCouleurCaseBase.signal_connect "color-set" do
            @config["caseBase"]=@boutonCouleurCaseBase.color
        end

        @boutonCouleurCaseSelectionne.signal_connect "color-set" do
            @config["caseSelectionne"]=@boutonCouleurCaseSelectionne.color
        end

        @boutonCouleurTexte.signal_connect "color-set" do
            @config["couleurTexte"]=@boutonCouleurTexte.color
        end

        @boutonCouleurIndices.signal_connect "color-set" do
            @config["couleurIndices"]=@boutonCouleurIndices.color
        end

        @boutonPolice.signal_connect "font-set" do
            font = @boutonPolice.font_name
            @config["taillePolice"]=font.slice!(-2,2)
            @config["police"]=font
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
