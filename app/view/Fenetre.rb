# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

require "optparse"
require "fileutils"

##
## Module regroupant les informations de base de chaque fenêtre
##
module Fenetre

    ## Définit la couleur blanche
    COULEUR_BLANC = Gdk::RGBA.new(1,1,1,1)
    ## Définit la couleur verte
    COULEUR_VERT = Gdk::RGBA.new(0, 1, 0, 1)
    ## Définit la couleur jaune
    COULEUR_JAUNE = Gdk::RGBA.new(1, 1, 0, 1)
    ## Définit la couleur rouge
    COULEUR_ROUGE = Gdk::RGBA.new(1, 0, 0, 1)
    ## Définit la couleur orange
    COULEUR_ORANGE = Gdk::RGBA.new(1, 0.6, 0, 1)
    ## Définit la couleur bleue
    COULEUR_BLEU = Gdk::RGBA.new(0.2, 0.59, 0.86, 1)
    ## Définit la taille du pseudo
    SIZE_PSEUDO = 20
    ## Définit la taille du titre 'Statistiques'
    SIZE_TITRE_STAT = 18
    ## Définit la taille du contenu des statistiques
    SIZE_CONTENU_STAT = 15
    ## Définit la taille du titre 'Score'
    SIZE_TITRE_SCORE = 18
    ## Définit la taille du contenu du score
    SIZE_CONTENU_SCORE = 15
    ## Définit la taille du titre 'Règles'
    SIZE_TITRE_REGLE = 15
    ## Définit la taille du contenu des règles
    SIZE_CONTENU_REGLE = 14
    ## Définit la taille du titre 'Règlages'
    SIZE_TITRE_REGLAGE = 15
    ## Définit la taille du titre
    SIZE_TITRE = 40
    ## Définit la taille des labels des boutons
    SIZE_LABEL_BOUTON = 20
    ## Définit la taille du titre du jeu
    SIZE_TITRE_JEU = 18
    ## Définit la taille du titre de l'autre jeu
    SIZE_AUTRE_JEU = 12
    ## Définit le menu
    FONT_MENU = "Monospace"

    ## VI
    @fenetre 
    @box
    @fenetrePrecedente
    @enteteFenetre

    ## VI barre menu
    @boutonMenu_barre
    @boutonSauvegarder_barre
    @boutonReinit_barre
    @boutonQuitter_barre
    @boutonPauseChrono_barre
    @boutonPlayChrono_barre
    @boutonAnnuler_barre
    @boutonRetablir_barre

    ## Création fenêtre de base
    @fenetre = Gtk::Window.new(:toplevel)
    @fenetre.set_name("mainWindow")
    @fenetre.set_icon_from_file(Core::ROOTPROJECT + "assets/img/iconApp.png")
    @fenetre.signal_connect('destroy') {
        detruire()
    }

    @fenetreStyle = @fenetre.style_context

    ## Création de la header bar
    @enteteFenetre                   = Gtk::HeaderBar.new()
    @enteteFenetre.show_close_button = true
    #@enteteFenetre.has_subtitle      = false

    ## Crée un conteneur pour le contenu
    @box=Gtk::Box.new(:vertical, 0)
    @fenetre.add(@box)

    ##
    ## Définit un accesseur pour le contexte de la fenêtre Gtk
    ##
    ## @return  fenetre
    ##
    def Fenetre.fenetre()
        return @fenetre
    end


    ##
    ## Définit un accesseur pour le contexte de l'entête de la fenêtre Gtk
    ##
    ## @return  enteteFenetre
    ##
    def Fenetre.enteteFenetre()
        return @enteteFenetre
    end
    
    ##
    ## Définit un accesseur pour le contexte de style de la fenêtre Gtk
    ##
    ## @return  fenetreStyle
    ##
    def Fenetre.fenetreStyle()
        return @fenetreStyle
    end
    
    ##
    ## Définit un accesseur pour le bouton de retour
    ##
    ## @return  boutonRetour
    ##
    def Fenetre.boutonRetour()
        return @boutonRetour
    end

    ##
    ## Définit un accesseur pour le bouton boutonMenu_barre
    ##
    ## @return  boutonMenu_barre
    ##
    def Fenetre.boutonMenu_barre()
        return @boutonMenu_barre
    end

    ##
    ## Définit un accesseur pour le bouton boutonSauvegarder_barre
    ##
    ## @return  boutonSauvegarder_barre
    ##
    def Fenetre.boutonSauvegarder_barre()
        return @boutonSauvegarder_barre
    end

    ##
    ## Définit un accesseur pour le bouton boutonReinit_barre
    ##
    ## @return  boutonReinit_barre
    ##
    def Fenetre.boutonReinit_barre()
        return @boutonReinit_barre
    end

    ##
    ## Définit un accesseur pour le bouton boutonQuitter_barre
    ##
    ## @return  boutonQuitter_barre
    ##
    def Fenetre.boutonQuitter_barre()
        return @boutonQuitter_barre
    end

    ##
    ## Définis un accesseur pour le bouton boutonPauseChrono_barre
    ##
    ## @return  boutonPauseChrono_barre
    ##
    def Fenetre.boutonPauseChrono_barre()
        return @boutonPauseChrono_barre
    end

    ##
    ## Définis un accesseur pour le bouton boutonPlayChrono_barre
    ##
    ## @return  boutonPlayChrono_barre
    ##
    def Fenetre.boutonPlayChrono_barre()
        return @boutonPlayChrono_barre
    end

    ##
    ## Définit un accesseur pour le bouton boutonAnnuler_barre
    ##
    ## @return  boutonAnnuler_barre
    ##
    def Fenetre.boutonAnnuler_barre()
        return @boutonAnnuler_barre
    end

    ##
    ## Définit un accesseur pour le bouton boutonRetablir_barre
    ##
    ## @return  boutonRetablir_barre
    ##
    def Fenetre.boutonRetablir_barre()
        return @boutonRetablir_barre
    end

    ##
    ## Applique une feuille css sur un widget
    ## 
    ## @param   widget          Widget sur lequel appliquer
    ## @param   chemin          Chemin du fichier css
    ## @param   fournisseur     Gtk provider pour le css
    ## @param   priorite        Priorité du style par rapport au système
    ## 
    ## @return  Style appliqué
    ##
    def Fenetre.css(**args)
        if(args.has_key?(:fournisseur))
            fournisseur = args[:fournisseur]
        else
            if(args.has_key?(:chemin))
                chemin = Core::ROOTPROJECT + args[:chemin]
            else
                chemin = Core::ROOTPROJECT + "assets/css/style.css"
            end
            fournisseur = Gtk::CssProvider.new
            fournisseur.load_from_path(chemin)
        end
        
        if(args.has_key?(:widget))
            widget = args[:widget]
        else
            widget = @fenetre
        end

        if(args.has_key?(:priorite))
            priorite = Object.const_get("Gtk::StyleProvider::" + args[:priorite])
        else
            priorite = Object.const_get("Gtk::StyleProvider::PRIORITY_USER")
        end

        widgetStyle = widget.style_context
        widgetStyle.add_provider(fournisseur, priorite)

        return unless widget.respond_to?(:children)
        widget.children.each do |child|
            args[:widget] = child
            self.css(args)
        end
    end

    ##
    ## Montre la fenêtre précédente
    ##
    def Fenetre.fenetrePrecedente()
        viderFenetre()

        @fenetrePrecedente.each() do |elt|
            @fenetre.add(elt)
        end

        @fenetre.show_all
    end

    ##
    ## Définit la fenêtre précédente
    ##
    ## @param   fenetre         Fenêtre précédente
    ##
    def Fenetre.fenetrePrecedente=(fenetre)
        @fenetrePrecedente = fenetre
    end

    ##
    ## Accesseur sur le layout
    ##
    def Fenetre.box()
        return @box
    end

    ##
    ## Vide la fenêtre pour préparer la mise à jour
    ##
    def Fenetre.viderFenetre()
        @fenetre.hide
        # puts @fenetre.children[0]
        @fenetre.children.each() do |child|
            @fenetre.child.each() do |chil|
                child.remove(chil)
            end
        end

    end

    ##
    ## Permet de quitter l'application et de détruire la fenêtre
    ##
    def Fenetre.detruire()
        Gtk.main_quit()
    end

    ##
    ## Applique un style css sur le widget
    ##
    ## @param   widget          Widget sur lequel appliquer un style
    ## @param   provider        
    ##
    def Fenetre.appliquerStyle(widget, provider)
        style_context = widget.style_context
        style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_USER)
        return unless widget.respond_to?(:children)
        widget.children.each do |child|
            apply_style(child, provider)
        end
    end
    
    ##
    ## Créer un label type à partir d'un string
    ##
    ## @param   unNomDeLabel    String représentant le texte du label
    ## @param   uneTaille       Taille de la police
    ## @param   une couleur     Couleur du texte
    ##
    ## @return  label
    ##
    def Fenetre.creerLabelType(unNomDeLabel, uneTaille)
        #Creation du Label
        label=Gtk::Label.new()
        label.set_markup("<span font_desc=\"#{FONT_MENU} #{uneTaille}\">#{unNomDeLabel}</span>")
        label.set_justify(Gtk::Justification::CENTER)
        return label
    end
    
    ##
    ## Crée un popup du type demandé
    ##
    ## @param   unTexte         Le texte à afficher
    ## @param   type            Le type de popup
    ##
    ## @return  L'objet dialog gtk
    ##
    def Fenetre.creerPopup(unTexte, type)
        messageErreur = Gtk::MessageDialog.new(
            :parent => @fenetre,
            :flags => Gtk::DialogFlags::DESTROY_WITH_PARENT,
            :type => Gtk::MessageType::INFO,
            :buttons => Object.const_get("Gtk::ButtonsType::" + type),
            :message => unTexte)
        return messageErreur
    end

    ##
    ## Crée la box horizontale contenant les boutons Retour et Quitter des fenêtres du menu
    ##
    ## @return  boxBottom
    ##
    def Fenetre.creerBoxBottom()
        #Création des boutons
        
        @boutonRetour=Gtk::Button.new(:label => "Retour")
        @boutonRetour.set_margin(40)
        @boutonRetour.signal_connect_after('clicked'){
            Core::back()
        }

        @boutonQuitter=Gtk::Button.new(:label => "Quitter")
        @boutonQuitter.set_margin(40)
        @boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #Ajout des boutons
        boxBottom=Gtk::Box.new(:horizontal, 0)
        boxBottom.halign = :center
        boxBottom.add(@boutonRetour)
        boxBottom.add(@boutonQuitter)
        return boxBottom
    end

    ## Permet de créer la barre de menu du haut
    ##
    ## @return  barreMenu
    ##
    def Fenetre.creerBarreMenu()
        barreMenu = Gtk::Toolbar.new()
        barreMenu.set_toolbar_style(Gtk::ToolbarStyle::ICONS)
        barreMenu.style_context.add_class("barre_menu")

        @boutonMenu_barre = Gtk::ToolButton.new(:stock_id => Gtk::Stock::HOME)
        @boutonMenu_barre.set_tooltip_text("Aller au menu principal")
        @boutonMenu_barre.set_margin_right(10)

        @boutonSauvegarder_barre = Gtk::ToolButton.new(:stock_id => Gtk::Stock::SAVE)
        @boutonSauvegarder_barre.set_tooltip_text("Sauvegarder")
        @boutonSauvegarder_barre.set_margin_right(10)

        @boutonReinit_barre = Gtk::ToolButton.new(:stock_id => Gtk::Stock::CLEAR)
        @boutonReinit_barre.set_tooltip_text("Réinitialiser la grille")
        @boutonReinit_barre.set_margin_right(10)

        @boutonQuitter_barre = Gtk::ToolButton.new(:stock_id => Gtk::Stock::QUIT)
        @boutonQuitter_barre.set_tooltip_text("Quitter")
        @boutonQuitter_barre.set_margin_right(10)

        @boutonPauseChrono_barre = Gtk::ToolButton.new(:stock_id => Gtk::Stock::MEDIA_PAUSE)
        @boutonPauseChrono_barre.set_tooltip_text("Mettre le jeu en pause")
        @boutonPauseChrono_barre.set_margin_right(10)

        @boutonPlayChrono_barre = Gtk::ToolButton.new(:stock_id => Gtk::Stock::MEDIA_PLAY)
        @boutonPlayChrono_barre.set_tooltip_text("Reprendre le jeu")
        @boutonPlayChrono_barre.set_margin_right(10)
    
        @boutonAnnuler_barre=Gtk::ToolButton.new(:stock_id => Gtk::Stock::UNDO)
        @boutonAnnuler_barre.set_tooltip_text("Annuler action")
        @boutonAnnuler_barre.set_margin_right(10)

        @boutonRetablir_barre=Gtk::ToolButton.new(:stock_id => Gtk::Stock::REDO)
        @boutonRetablir_barre.set_tooltip_text("Rétablir action annulée")
        @boutonRetablir_barre.set_margin_right(10)

        barreMenu.insert(@boutonMenu_barre,0)
        barreMenu.insert(@boutonSauvegarder_barre,1)
        barreMenu.insert(@boutonReinit_barre,2)
        barreMenu.insert(@boutonQuitter_barre,3)
        barreMenu.insert(Gtk::SeparatorToolItem.new(),4)
        barreMenu.insert(@boutonPauseChrono_barre,5)
        barreMenu.insert(@boutonPlayChrono_barre,6)
        barreMenu.insert(Gtk::SeparatorToolItem.new(),7)
        barreMenu.insert(@boutonAnnuler_barre,8)
        barreMenu.insert(@boutonRetablir_barre,9)

        #enabled
        @boutonMenu_barre.set_sensitive(true)
        @boutonSauvegarder_barre.set_sensitive(true)
        @boutonReinit_barre.set_sensitive(true)
        @boutonQuitter_barre.set_sensitive(true)
        @boutonPauseChrono_barre.set_sensitive(true)
        @boutonPlayChrono_barre.set_sensitive(true)
        @boutonAnnuler_barre.set_sensitive(true)
        @boutonRetablir_barre.set_sensitive(true)

        return barreMenu
    end
end
