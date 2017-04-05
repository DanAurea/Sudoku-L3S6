require "observer"

## => Author::      DanAurea
## => version::     0.1
## => copyright::   © 2016
## => license::     Distributes under the same terms as Ruby

##
## Classe permettant de dessiner les cases d'une grille de Sudoku 
##
class CaseDessin < Gtk::DrawingArea
    include Observable

    attr_accessor :x, :y, :largeur, :hauteur, :taillePolice, :nombre

    ##
    ## Initialisation
    ##
    def initialize valeur

        super()
        
        @largeur = 40
        @hauteur = 40

        @x = 0
        @y = 0

        @taillePolice = @largeur / 3

        @couleurCase       = Gdk::Color.new(65535, 65535, 65535)
        @couleurCaseFixe   = Gdk::Color.new(61500, 61500, 61500)
        @couleurIndices    = Gdk::Color.new(0, 0, 0)
        @couleurPolice     = Gdk::Color.new(0, 0, 0)
        @couleurSurlignees = Gdk::Color.new(0, 50000, 50000)

        @nombre   = valeur["value"]

        ## Correspond à une case déjà remplie par le générateur
        ## donc non éditable
        @editable = valeur["editable"]
        @focus    = false

        ## Crée la zone de dessin au signal draw
        signal_connect "draw" do  |_, cr|
            dessiner cr
        end

        if(@editable == true)
            ## Ajoute les évènements de survol et de clics
            add_events(Gdk::EventMask::ENTER_NOTIFY_MASK)
            add_events(Gdk::EventMask::BUTTON_PRESS_MASK)

            ## Lie un callback sur la souris
            signal_connect "button_press_event" do |widget, evenement|
                @focus = true
                clicSouris widget, evenement
            end

            ## Lie un callback sur le survol de la souris
            # signal_connect "enter_notify_event" do |widget, evenement|
            #     # puts "test"
            # end
        end

    end

    ##
    ## Callback sur l'appui sur la souris (évènement ajouté à la main)
    ##
    ## @return  itself
    ##
    def clicSouris widget, evenement

        if evenement.button == 1
            self.afficherChiffres
        elsif evenement.button == 2
            puts "middle click pressed"
        elsif evenement.button == 3
            puts "right click pressed"
        end

        return self
    end


    ##
    ## Affiche les chiffres au dessus de la case pour changer la valeur de la case.
    ##
    ## @return  itself
    ##
    def afficherChiffres()
        popover = Gtk::Popover.new(self)

        popover.position = :bottom
        


        ## Ajoute le contenu du popover
        child = Gtk::Grid.new()

        ## Ajoute les chiffres à la grille du popover
        self.ajouterChiffres(child)
        
        ## Définis les espaces entre les chiffres
        child.row_spacing = 5
        child.column_spacing = 5

        popover.add(child)
        
        popover.show_all


        ## Cache le popover quand un clic est détecté 
        ## A corriger: ne cacher que si clic en dehors de la zone
        popover.signal_connect "button_press_event" do
            popover.hide()
            @focus = false
        end

        return self  
    end

    ##
    ## Permet d'ajouter des chiffres sur les cases vides de la grille
    ## 
    ## @param   grillePopover   Grille
    ## 
    def ajouterChiffres(grillePopover)

        chiffres = Hash.new()
        
        (1..9).each do |value|
            chiffres[value.to_s] = Gtk::Button.new(:label => value.to_s)
        end

        row = 0
        col = 0
        parLigne = 2

        ## Place les chiffres dans le layout grille
        chiffres.each do |_, bouton|
            grillePopover.attach bouton, col, row , 1, 1

            col += 1
            if(col > parLigne)
                row += 1
                col  = 0
            end

            ## Change la valeur de la case si appui détecté
            bouton.signal_connect "button_press_event" do |widget|
                mettreAJour(widget.label.to_i)
                redessiner()
            end
        end 
    end

    ##
    ## Edite la couleur de la case
    ## 
    ## @param   cr      case
    ## 
    def couleurCase cr
        if(@editable && !@focus)
            cr.set_source_color @couleurCase
        elsif(@focus)
            cr.set_source_color @couleurSurlignees
        else
            cr.set_source_color @couleurCaseFixe
        end
    end

    ##
    ## Edite la couleur de la police
    ## 
    def couleurPolice cr
        cr.set_source_color @couleurPolice
    end

    ##
    ## Met à jour la valeur de la case
    ## 
    ## @param   valeur      La valeur à mettre à jour
    ## 
    def mettreAJour(valeur)
        changed
        @nombre = valeur

        notify_observers(self)
    end

    ##
    ## Redessine la case avec les nouvelles valeurs si modifiées
    ## 
    def redessiner()
        self.queue_draw
    end

    ##
    ## Dessine une case
    ## 
    ## @param   cr  case à dessiner
    ## 
    ## @return  itself
    def dessiner cr

        set_size_request(@largeur, @hauteur)

        ## Définit la couleur pour le dessin (ici blanc)
        self.couleurCase cr

        ## Dessine un rectangle
        cr.rectangle @x, @y, @largeur, @hauteur
        cr.fill

        ## Définit une nouvelle couleur (ici noire)
        cr.set_source_color @couleurPolice

        ## Définit les caractéristiques du texte
        cr.select_font_face "Arial", 
            Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL
        cr.set_font_size @taillePolice

        extents = cr.text_extents @nombre.to_s
        cr.move_to @x + @largeur / 2 - extents.width / 2, @y + @hauteur / 2 + extents.height / 2 ## Déplace le curseur de texte au centre de la case
        cr.show_text @nombre.to_s

        cr.set_source_rgb 0.5, 0.5, 0.5

        cr.move_to @x , @y
        cr.set_line_width 0.5

        ## Calcule le chemin du contour de la case
        cr.rel_line_to @largeur, 0
        cr.rel_line_to 0, @hauteur
        cr.rel_line_to -@largeur, 0
        cr.rel_line_to 0, -@hauteur

        cr.stroke

        return self

    end

end
