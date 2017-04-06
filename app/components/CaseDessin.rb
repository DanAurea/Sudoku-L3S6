require "observer"
require Core::ROOT + "model/Configuration.rb"

class CaseDessin < Gtk::DrawingArea
    include Observable

    attr_accessor :x, :y, :size, :taillePolice, :nombre, :editable, :indices, :indice, :state, :couleurCase, :couleurCaseFixe, :couleurIndices, :couleurPolice, :couleurSurlignee

    def initialize valeur, config

        super()
        
        @x = 0
        @y = 0

        @nombre   = valeur["value"]
        @editable = valeur["editable"]
        @state    = ""

        @indices  = {"1" => false, "2" => false, "3" => false, "4" => false, "5" => false, "6" => false, "7" => false, "8" => false, "9" => false}
        @indice   = false

        config = config
        @configurationModel = Configuration.instance()

        @police        = config["police"]
        @taillePolice  = config["taillePolice"]
        @tailleIndices = @taillePolice / 2

        # Prend en compte la configuration utilisateur
        @couleurCase       = @configurationModel.creerCouleur(config["caseBase"])
        @couleurCaseFixe   = @configurationModel.creerCouleur(config["caseFixe"])
        @couleurIndices    = @configurationModel.creerCouleur(config["couleurIndices"])
        @couleurPolice     = @configurationModel.creerCouleur(config["couleurTexte"])
        @couleurSurlignee  = @configurationModel.creerCouleur(config["caseSelectionne"])

        ## Crée la zone de dessin au signal draw
        signal_connect "draw" do  |_, cr|
            dessiner cr
        end

        if(@editable == true)
            ## Ajoute les évènement de survol et de clics
            add_events(Gdk::EventMask::ENTER_NOTIFY_MASK)
            add_events(Gdk::EventMask::BUTTON_PRESS_MASK)
            add_events(Gdk::EventMask::LEAVE_NOTIFY_MASK)

            ## Lie un callback sur la souris
            signal_connect "button_press_event" do |_, evenement|
                focused evenement
            end

            ## Lie un callback sur l'entrée du curseur dans la zone
            signal_connect "enter_notify_event" do 
                hover 
            end

            ## Lie un callback sur la sortie du curseur de la zone
            signal_connect "leave_notify_event" do 
                leave
            end

        end

    end

    ##
    ## Réinitialise les indices de la cases
    ##
    ## @return     self
    ##
    def resetIndices
        @indices = {"1" => false, "2" => false, "3" => false, "4" => false, "5" => false, "6" => false, "7" => false, "8" => false, "9" => false}
    end

    ##
    ## Callback sur l'appui sur la souris (évènement ajouté à la main)
    ##
    ## @return     Self
    ##
    def focused evenement
        changed

        ## Clic gauche
        if evenement.button == 1
            @state = "clicked"
        end

        notify_observers(@x, @y, @state)
        
        return self
    end


    ##
    ## Action lors du survol de la case
    ##
    ## @return     Self
    ##
    def hover
        changed
        
        @state = "hover"

        notify_observers(@x, @y, @state)

        return self
    end

    ##
    ## Définis l'état en prenant en compte des priorités
    ##
    ## @return     State
    ##
    def set_state=(etat)
        if(@state != "equal")
            @state = etat
        end
    end

    ##
    ## Action lors de la sortie du curseur de la case
    ##
    ## @return     Self
    ##
    def leave
        changed

        @state = "leave"

        notify_observers(@x, @y, @state)

        return self
    end


    ##
    ## @brief      Affiche les chiffres au dessus de la case
    ##              pour changer la valeur de la case.
    ##
    ##
    ## @return     
    ##
    # def afficherChiffres()
    #     popover = Gtk::Popover.new(self)

    #     popover.position = :bottom
        


    #     ## Ajoute le contenu du popover
    #     child = Gtk::Grid.new()

    #     ## Ajoute les chiffres à la grille du popover
    #     self.ajouterChiffres(child)
        
    #     ## Définis les espaces entre les chiffres
    #     child.row_spacing = 5
    #     child.column_spacing = 5

    #     popover.add(child)
        
    #     popover.show_all


    #     ## Cache le popover quand un clic est détecté 
    #     ## A corriger: ne cacher que si clic en dehors de la zone
    #     popover.signal_connect "button_press_event" do
    #         popover.hide()
    #         @focus = false
    #     end

    #     return self  
    # end

    # def ajouterChiffres(grillePopover)

    #     chiffres = Hash.new()
        
    #     (1..9).each do |value|
    #         chiffres[value.to_s] = Gtk::Button.new(:label => value.to_s)
    #     end

    #     row = 0
    #     col = 0
    #     parLigne = 2

    #     ## Place les chiffres dans le layout grille
    #     chiffres.each do |_, bouton|
    #         grillePopover.attach bouton, col, row , 1, 1

    #         col += 1
    #         if(col > parLigne)
    #             row += 1
    #             col  = 0
    #         end

    #         ## Change la valeur de la case si appui détecté
    #         bouton.signal_connect "button_press_event" do |widget|
    #             mettreAJour(widget.label.to_i)
    #             redessiner()
    #         end
    #     end 
    # end


    ##
    ## Définis la couleur de la case
    ##
    ## @return self
    ##
    def couleurCase cr
        if(@editable && @state != "focus" && @state != "hover")
            cr.set_source_color @couleurCase
        elsif(@state == "focus" || @state == "hover")
            cr.set_source_color @couleurSurlignee
        elsif(@state == "equal")

            rouge, vert, bleu  = @couleurSurlignee.red * 0.7, @couleurSurlignee.green * 0.7, @couleurSurlignee.blue * 0.7
            composantes = [rouge, vert, bleu].join(",")

            cr.set_source_color @configurationModel.creerCouleur(composantes)

        else
            cr.set_source_color @couleurCaseFixe
        end

        return self
    end


    ##
    ## Définis la couleur de la police dans la case
    ##
    ## @return self
    ##
    def couleurPolice cr
        if((@indice == false || !@editable || @nombre != nil)) 
            cr.set_source_color @couleurPolice
        else
            cr.set_source_color @couleurIndices
        end

        return self
    end

    def redessiner()
        self.queue_draw
    end

    ##
    ## Dessine une case
    ##
    ##
    def dessiner cr

        ## On définit la taille comme 1/12 de la fenêtre pour garder de l'espace
        ## pour les boutons
        @size = Fenetre::fenetre.size[1] / 12

        ## Définis la largeur et la hauteur de la case (obligatoire pour gestion des évènements)
        set_size_request(@size, @size )

        ## Définis la couleur pour le dessin en fonction du type de case
        self.couleurCase cr

        ## Dessine un rectangle
        cr.rectangle 0, 0, @size, @size
        cr.fill

        ## Définis la couleur du texte
        self.couleurPolice cr

        if(@indice == false || !@editable || @nombre != nil)
            dessinerChiffre cr
        else
            dessinerIndices cr
        end

        dessinerContour cr

        cr.stroke

        return self

    end


    ##
    ## Dessine le contour de la case
    ##
    ##
    def dessinerContour cr
        cr.set_source_rgb 0, 0, 0

        cr.move_to 0 , 0

        cr.set_line_width 0.5

        ## Calcule le chemin du contour de la case
        cr.rel_line_to @size, 0
        cr.rel_line_to 0, @size
        cr.rel_line_to -@size, 0
        cr.rel_line_to 0, -@size
        cr.stroke

        cr.set_line_width 7

        ## Bordure exétieure haut
        if(@x == 0)
            cr.move_to 0, 0
            cr.line_to @size, 0
            cr.stroke
        end

        ## Bordure extérieur gauche
        if(@y == 0)
            cr.move_to 0, 0
            cr.line_to 0, @size
            cr.stroke
        end

        ## Bordure bas
        if(@x == 8 || @x % 3 == 2)
            cr.move_to 0, @size
            cr.line_to @size, @size
            cr.stroke
        end

        ## Bordure droite
        if(@y == 8 || @y % 3 == 2)
            cr.move_to @size, 0
            cr.rel_line_to 0, @size
            cr.stroke
        end

    end

    ##
    ## Dessine le chiffre
    ##
    ## @return     { description_of_the_return_value }
    ##
    def dessinerChiffre cr
        ## Définis les caractéristiques du texte
        cr.select_font_face @police, 
            Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL
        cr.set_font_size @taillePolice

        extents = cr.text_extents @nombre.to_s
        cr.move_to @size / 2 - extents.width / 2,  @size / 2 + extents.height / 2 
        ## Déplace le curseur de texte au centre de la case
        cr.show_text @nombre.to_s
    end

    ##
    ## Dessine les indices
    ##
    ## 
    ##
    def dessinerIndices cr        
        cr.set_font_size @tailleIndices

        col = 1
        lig = 1
        @indices.each do | key, value|
            
            if(value == true)
                extents = cr.text_extents key
                cr.move_to (col * @size / 4) - extents.width / 2 , (lig * @size / 4).floor + (extents.height / 2).floor
                ## Déplace le curseur de texte au centre de la case
                cr.show_text key
            end

            if key.to_i % 3 == 0
                lig += 1
                col = 0
            end
            col += 1
        end
    end

end