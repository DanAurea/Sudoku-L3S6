class CaseDessin < Gtk::DrawingArea

    attr_accessor :x, :y, :largeur, :hauteur, :taillePolice

    def initialize nombre

        super()
        
        @largeur = 40
        @hauteur = 40

        @x = 0
        @y = 0

        @taillePolice = @largeur / 3

        @nombre = nombre
        
        ## Crée la zone de dessin au signal draw
        signal_connect "draw" do  |widget, cr|
            dessiner cr
        end

        ## Ajoute un évènement (signal) à saisir ici c'est l'appui sur un bouton de la souris
        add_events(Gdk::EventMask::BUTTON_PRESS_MASK)

        ## Lie un callback sur la souris
        signal_connect "button_press_event" do |widget, evenement|
            clicSouris evenement
        end

    end

    ##
    ## @brief      Callback sur l'appui sur la souris (évènement ajouté à la main)
    ##
    ## @return
    ##
    def clicSouris evenement

        if evenement.button == 1
            puts "left click pressed"
        elsif evenement.button == 2
            puts "middle click pressed"
        elsif evenement.button == 3
            puts "right click pressed"
        end

        return self
    end

    ##
    ## @brief      Dessine une case
    ##
    ##
    def dessiner cr

        set_size_request(@largeur, @hauteur)

        ## Définis la couleur pour le dessin (ici blanc)
        cr.set_source_rgb 1.0, 1.0, 1.0

        ## Dessine un rectangle
        cr.rectangle @x, @y, @largeur, @hauteur
        cr.fill

        ## Définis une nouvelle couleur (ici noire)
        cr.set_source_rgb 0.0, 0.0, 0.0

        ## Définis les caractéristiques du texte
        cr.select_font_face "Arial", 
            Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL
        cr.set_font_size @taillePolice

        extents = cr.text_extents @nombre
        cr.move_to @x + @largeur / 2 - extents.width / 2, @y + @hauteur / 2 + extents.height / 2 ## Déplace le curseur de texte au centre de la case
        cr.show_text @nombre

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