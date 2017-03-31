# => Contient la classe abstraite Fenetre regroupant les informations de base de chaque fenêtre
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

require "optparse"
require "fileutils"

##
## classe abstraite Fenetre regroupant les informations de base et méthodes de chaque fenêtre
##
module Fenetre
    ## VI
    @fenetre 
    @box
    @fenetrePrecedente

    ## Création fenêtre de base
    @fenetre = Gtk::Window.new()
    @fenetre.set_name("mainWindow")
    @fenetreStyle = @fenetre.style_context
    @fenetre.signal_connect('destroy') {
       detruire()
   }

    ##
    ## Définis un accesseur pour le contexte de la fenêtre Gtk
    ##
    ## @return  fenetre
    ##
    def Fenetre.fenetre()
        return @fenetre
    end
    
    ##
    ## Définis un accesseur pour le contexte de style de la fenêtre Gtk
    ##
    ## @return fenetreStyle
    ##
    def Fenetre.fenetreStyle()
        return @fenetreStyle
    end
    
    ##
    ## Applique une feuille css sur un widget
    ## 
    ## @param   widget     Widget sur lequel appliquer
    ## @param   chemin     Chemin du fichier css
    ## @param   fournisseur Gtk provider pour le css
    ## @param   priorite   Priorité du style par rapport au système
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
    ##
    def Fenetre.fenetrePrecedente()
        viderFenetre()

        @fenetrePrecedente.each() do |elt|
            @fenetre.add(elt)
        end

        @fenetre.show_all
    end

    ##
    ## Définis la fenêtre précédente
    ##
    ## @param   fenetre
    ##
    ##
    def Fenetre.fenetrePrecedente=(fenetre)
        @fenetrePrecedente = fenetre
    end

    ##
    ## Accesseur sur le layout
    ##
    ##
    def Fenetre.box()
        return @box
    end

    ##
    ## Vide la fenêtre pour préparer la mise à jour
    ##
    ##
    def Fenetre.viderFenetre()
        @fenetre.children.each() do |child|
            @fenetre.remove(child)
        end
    end

    ##
    ## Permet de quitter l'application et de detruire la fenetre
    ##
    ##
    def Fenetre.detruire()
        Gtk.main_quit()
    end

    ##
    ## Applique un style css sur le widget
    ##
    ## @param   widget Widget sur lequel appliquer un style
    ## @param   provider  
    ##
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
    ## Permet de mettre en place la fenêtre via un conteneur principal VBox
    ##
    ##
    def Fenetre.miseEnPlace()
        #Conteneur VBox
        @box=Gtk::Box.new(:vertical, 0)
        @fenetre.add(@box)
    end
    
    ##
    ## Créer un label type à partir d'un string
    ##
    ## @param   unNomDeLabel string représentant le texte du label
    ##
    ## @return  Label
    ##
    def Fenetre.creerLabelType(unNomDeLabel)
        #Creation du Label
        label=Gtk::Label.new()
        label.set_markup(unNomDeLabel)
        label.set_justify(Gtk::Justification::CENTER)
        return label
    end
    
    ##
    ## Créer une popup d'avertissement avec un simple texte
    ##
    ## @param   unTexte Chaine de caractères informative
    ##
    ## @return  MessageDialog
    ##
    def Fenetre.creerPopupErreur(unTexte)
    	messageErreur = Gtk::MessageDialog.new(
    		:parent => @fenetre,
    		:flags => Gtk::DialogFlags::DESTROY_WITH_PARENT,
    		:type => Gtk::MessageType::INFO,
    		:buttons => Gtk::ButtonsType::CLOSE,
    		:message => unTexte)
    	messageErreur.run()
    	messageErreur.destroy()
    	return messageErreur
    end
    
    ##
    ## Créer une popup question oui ou non avec un simple texte
    ##
    ## @param   unTexte Chaine de caractères informative
    ##
    ## @return  MessageDialog
    ##
    def Fenetre.creerPopupQuestion(unTexte)
    	messageErreur = Gtk::MessageDialog.new(
    		:parent => @fenetre,
    		:flags => Gtk::DialogFlags::DESTROY_WITH_PARENT,
    		:type => Gtk::MessageType::QUESTION,
    		:buttons => Gtk::ButtonsType::YES_NO,
    		:message => unTexte)
    	return messageErreur
    end

    ##
    ## Créer la box horizontale contenant les boutons retour et quitter des fenêtres du menu
    ##
    ## @return Box
    ##
    def Fenetre.creerBoxBottom()
        #Creation des Boutons
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

        #add des boutons
        boxBottom=Gtk::Box.new(:horizontal, 0)
        boxBottom.halign = :center
        boxBottom.add(boutonRetour)
        boxBottom.add(boutonQuitter)
        return boxBottom
    end
end
