require "observer"
require Core::ROOT + "model/Configuration.rb"

## => Author::      DanAurea
## => version::     0.1
## => copyright::   © 2016
## => license::     Distributes under the same terms as Ruby

##
## Classe permettant de dessiner les cases d'une grille de Sudoku 
##
class CaseDessin < Gtk::DrawingArea
    include Observable

    attr_accessor :x, :y, :size, :taillePolice, :nombre, :editable, :indices, :indice, :state

    ##
    ## Initialisation
    ##
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
            ## Ajoute les évènements de survol et de clics
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
    def resetIndices
        @indices = {"1" => false, "2" => false, "3" => false, "4" => false, "5" => false, "6" => false, "7" => false, "8" => false, "9" => false}
    end

    ##
    ## Callback sur l'appui sur la souris (évènement ajouté à la main)
    ##
    ## @return  self
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
    ## @return     self
    ##
    def hover
        changed
        
        @state = "hover"

        notify_observers(@x, @y, @state)

        return self
    end

    ##
    ## Définit l'état
    ##
    def set_state=(etat)
        if(@state != "equal")
            @state = etat
        end
    end

    ##
    ## Action lors de la sortie du curseur de la case
    ##
    ## @return     self
    ##
    def leave
        changed

        @state = "leave"

        notify_observers(@x, @y, @state)

        return self
    end
   
    ##
    ## Edite la couleur de la case
    ## 
    ## @param   cr      case
    ## 
    ## @return  self
    ## 
    def couleurCase cr
        if(@editable && @state != "focus" && @state != "hover")
            cr.set_source_color @couleurCase
        elsif(@state == "focus" || @state == "hover")
            cr.set_source_color @couleurSurlignee
        elsif(@state == "equal")
            coeff = 0.7
            rouge, vert, bleu  = @couleurSurlignee.red * coeff, @couleurSurlignee.green * coeff, @couleurSurlignee.blue * coeff
            composantes = [rouge, vert, bleu].join(",")

            cr.set_source_color @configurationModel.creerCouleur(composantes)

        else
            cr.set_source_color @couleurCaseFixe
        end

        return self
    end

    ##
    ## Définit la couleur de la police dans la case
    ## 
    ## @param cr    case
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
    ## @return  self
    ##
    def dessiner cr

        ## On définit la taille comme 1/12 de la fenêtre pour garder de l'espace
        ## pour les boutons
        @size = Fenetre::fenetre.size[1] / 12

        ## Définit la largeur et la hauteur de la case (obligatoire pour gestion des évènements)
        set_size_request(@size, @size )

        ## Définit la couleur pour le dessin en fonction du type de case
        self.couleurCase cr

        ## Dessine un rectangle
        cr.rectangle 0, 0, @size, @size
        cr.fill

        ## Définit la couleur du texte
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
    ## @param   cr      case
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
