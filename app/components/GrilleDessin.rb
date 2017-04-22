require_relative "CaseDessin.rb"
require "observer"

## => Author::      DanAurea
## => version::     0.1
## => copyright::   © 2016
## => license::     Distributes under the same terms as Ruby

##
## Classe permettant de dessiner la grille
## 
class GrilleDessin < Gtk::Grid
    include Observable
    
    attr_accessor :cases

    def initialize valeurs, config
        
        super() 

        @size = 40
             
        @nbCases     = 9
        @cases       = Array.new(@nbCases)
            
        @indices = false

        set_margin_top(10);
        set_margin_left(10);
        
        valeurs.each_with_index do |ligne, ligneIndex|
            
            @cases[ligneIndex] = Array.new()

            ligne.each_with_index do |valeur, colonneIndex|
                c = CaseDessin.new valeur, config
                c.add_observer(self)
                c.size = @size
                
                c.x = ligneIndex
                c.y = colonneIndex

                @cases[ligneIndex] << c

                attach c, colonneIndex, ligneIndex , 1, 1
            end
        end

    end

    ##
    ## Réinitialise les indices de toutes les cases
    ##
    def resetIndices()
        @cases.each do |ligne|
            ligne.each do |c|
                c.resetIndices
            end
        end
    end

    ##
    ## Définit l'état visuel des indices
    ##
    ## @return     self
    ##
    def indices=(bool)

        @indices = bool

        for i in 0..8
            for j in 0..8
                @cases[i][j].indice = bool
            end
        end

        return self
    end

    ##
    ## Renvoie l'état visuel des indices
    ##
    ## @return     true si affiché sinon false 
    ##
    def indices?
        return @indices
    end

    ##
    ## Redessine la grille en mettant à jour les informations
    ##
    ##
    ## @return     self
    ##
    def redessiner()

        for i in 0..8
            for j in 0..8
                @cases[i][j].redessiner
            end
        end

        return self
    end

    ##
    ## Réinitialise l'état de toutes les cases
    ##
    ## @return     self
    ##
    def reset()
        for i in 0..8
            for j in 0..8
                @cases[i][j].state = ""
            end
        end
    end

    ##
    ## Affiche les valeurs identiques en une couleur différente
    ##
    ## @param      valeur  La valeur à comparer
    ##
    ## @return     self
    ##
    def memeValeurs(valeur)
        for i in 0..8
            for j in 0..8
                if(@cases[i][j].nombre == valeur)
                    @cases[i][j].state = "equal"
                end
            end
        end
    end


    ##
    ## Colorie la région aux cordonnéees rX et rY
    ##
    ## @param      rX    Coordonnée x de la région
    ## @param      rY    Coordonnée y de la région
    ## @param      etat  Etat à afficher
    ##
    ## @return     self
    ##
    def colorierRegion(rX, rY, etat)
        ## Colorie la région
        for i in 0..2
            for j in 0..2

                @cases[rX + i][rY + j].set_state = etat
                @cases[rX + i][rY + j].redessiner
            end
        end

        return self
    end


    ##
    ## Modifie les coordonnées pour donner les coordonnées de la première case
    ## du bloc.
    ##
    ## @param      rX    Coordonnée x
    ## @param      rY    Coordonnée y
    ##
    ## @return     Retourne coordonnées mises à jour
    ##
    def premiereCaseBloc!(rX, rY)
        ## Récupère les cordonnées de la première case de la région
        while(rX % 3 != 0 || rY % 3 != 0)
            if(rX % 3 != 0)
                rX -= 1
            end
            if(rY % 3 != 0)
                rY -=1
            end
        end

        return rX, rY
    end

    ##
    ## Met en surbillance la région
    ##
    ## @param      x     Position x d'une case
    ## @param      y     Position y d'une case
    ## @param      etat  Etat
    ##
    ## @return     self
    ##
    def colorierBloc(x, y, etat)

        # Position x et y de la région
        rX = x
        rY = y

        rX, rY = self.premiereCaseBloc!(rX, rY)

        self.colorierRegion(rX, rY, etat)

        return self
    end

    ##
    ## Mise à jour de l'observateur
    ##
    ## @param      x     position x de la case sélectionnée
    ## @param      y     position y de la case sélectionnée
    ## @param      etat  L'état
    ##
    ## @return self
    ##
    def update(x, y, etat)
        
        for i in 0..@nbCases - 1
            for j in 0..@nbCases - 1
                    @cases[x][j].set_state = etat
                    @cases[x][j].redessiner
                    @cases[i][y].set_state = etat
                    @cases[i][y].redessiner
            end
        end

        self.colorierBloc(x, y, etat)
        
        if(etat == "clicked" && Header.pause == false)
            changed
            notify_observers(x, y)
        end

        return self
    end

end