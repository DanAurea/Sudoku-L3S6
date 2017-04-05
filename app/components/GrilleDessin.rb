require_relative "CaseDessin.rb"
require "observer"

class GrilleDessin < Gtk::Grid
    include Observable
    
    def initialize valeurs
        
        super() 

        @size = 40
             
        @nbCases     = 9
        @cases       = Array.new(@nbCases)
        
        set_margin_top(10);
        set_margin_left(10);
        
        valeurs.each_with_index do |ligne, ligneIndex|
            
            @cases[ligneIndex] = Array.new()

            ligne.each_with_index do |valeur, colonneIndex|
                c = CaseDessin.new valeur
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
    ## Limite le dépassement de valeur d'une couleur 16 bits
    ##
    ## @param      couleur  La couleur à vérifier
    ##
    ## @return     La couleur limitée à la borne si dépassement sinon la couleur elle même
    ##
    def verifierCouleur(couleur)
        max = 65535
        min = 0

        if(couleur >  max)
            couleur = max
        elsif(couleur < 0)
            couleur = min
        end

        return couleur
    end

    ##
    ## Redessine la grille en mettant à jour les couleurs
    ##
    ## @param      x     position x de la case sélectionnée
    ## @param      y     position y de la case sélectionnée
    ## @param      etat  L'état de la case
    ##
    ## @return self
    ##
    def redessiner(x,y, etat)

        for i in 0..@nbCases - 1
            for j in 0..@nbCases - 1
                    @cases[x][j].state = etat
                    @cases[x][j].redessiner
                    @cases[i][y].state = etat
                    @cases[i][y].redessiner
            end
        end

        self.colorierBloc(x, y, etat)

        return self
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

        ## Récupère les cordonnées de la première case de la région
        while(rX % 3 != 0 || rY % 3 != 0)
            if(rX % 3 != 0)
                rX -= 1
            end
            if(rY % 3 != 0)
                rY -=1
            end
        end

         ## Coefficient pour éclaircir
        coeff = 1.3

        couleurSurlignee = @cases[x][y].couleurSurlignee
        rouge, vert, bleu = couleurSurlignee.red * coeff, couleurSurlignee.green * coeff, couleurSurlignee.blue * coeff

        rouge = self.verifierCouleur(rouge)
        vert =self.verifierCouleur(vert)
        bleu =self.verifierCouleur(bleu)

        couleurBloc = Gdk::Color.new(rouge, vert, bleu)

        ## Colorie la région d'une couleur plus claire
        for i in 0..2
            for j in 0..2

                @cases[rX + i][rY + j].state = etat
                @cases[rX + i][rY + j].redessiner
            end
        end

        return self
    end

    ##
    ## Mise à jour observateur
    ##
    ## @param      x     postion x de la case sélectionnée
    ## @param      y     position y de la case sélectionnée
    ## @param      etat  L'état
    ##
    ## @return self
    ##
    def update(x, y, etat)
        self.redessiner x,y, etat
        return self
    end

end