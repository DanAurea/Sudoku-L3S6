#   Fichier contenant la gestion des reglages(taille, couleur)
#
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
#   Version::       0.1
#   Copyright::     © 2016
#   License::       Distributes under the same terms as Ruby
#

class FenetreReglages < View

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
        labelCouleurCaseSelectionne = Fenetre::creerLabelType("Couleur des cases sélectionnées:")
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

        boutonCouleurCaseBase = Gtk::ColorButton.new()
        boutonCouleurCaseBase.style_context.add_class("bouton_reglage")
        boutonCouleurCaseSelectionne = Gtk::ColorButton.new()
        boutonCouleurCaseSelectionne.style_context.add_class("bouton_reglage")
        boutonCouleurTexte = Gtk::ColorButton.new()
        boutonCouleurTexte.style_context.add_class("bouton_reglage")
        boutonCouleurIndices = Gtk::ColorButton.new()
        boutonCouleurIndices.style_context.add_class("bouton_reglage")
        boutonPolice = Gtk::FontButton.new()
        boutonPolice.style_context.add_class("bouton_reglage")

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

        #tableau reglages
        table=Gtk::Table.new(2,5,false)
        table.attach(labelCouleurCaseBase,0,1,0,1)
        table.attach(boutonCouleurCaseBase,1,2,0,1)

        table.attach(labelCouleurCaseSelectionne,0,1,1,2)
        table.attach(boutonCouleurCaseSelectionne,1,2,1,2)

        table.attach(labelCouleurTexte,0,1,2,3)
        table.attach(boutonCouleurTexte,1,2,2,3)

        table.attach(labelCouleurIndices,0,1,3,4)
        table.attach(boutonCouleurIndices,1,2,3,4)

        table.attach(labelPolice,0,1,4,5)
        table.attach(boutonPolice,1,2,4,5)

        #add des boutons
        boxTop=Gtk::Box.new(:vertical,0)
        boxTop.add(event_box)
        boxTop.add(titre)
        boxTop.add(tmp)
        boxTop.add(table)

        boxBottom=Gtk::Box.new(:horizontal, 0)
        boxBottom.halign = :center
        boxBottom.add(boutonRetour)
        boxBottom.add(boutonQuitter)
        
        Fenetre::box.add(boxTop)
        Fenetre::box.add(boxBottom)
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
        Fenetre::css(:chemin => "/assets/css/FenetreReglages.css")
        return self
    end

end
