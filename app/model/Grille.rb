require Core::ROOT + "utils/Generateur.rb"

class Grille < Model

    def initialize()
        @gen = Generateur.new()
        @grille = nil
    end

    def generer(niveau)
        @grille = @gen.generer(niveau)
        return @grille
    end

    def charger(pseudo)
        #return grille
    end

    def sauvegarder(pseudo)
        YAML.save_file(@grille)
        return true
    end

    def supprimer(pseudo)
        return true
    end

    ## Retourne vrai si la cellule est bien unique
    def valeurUnique(x ,y)
        ## Le compte rendu de l'inspection
        cr = true

        ## Initialisation pour le parcours du block
        block = Array.new()
        x = ((num-1)*3)%9
        y = num/3*3
        block << grille[x..x+2][y..y+2]

        ## Parcours dans [0,8]
        for i in 0..8

            ## Verification horizontale
            if(@grille[x][i] == @grille[x][y])
                ## La valeur unique s'errone
                @grille[x][i]["unique"] = false
                ## La case verifié aussi
                @grille[x][y]["unique"] = false
                cr = false
            end

            ## Verification verticale
            if(@grille[i][y] == @grille[x][y])
                ## La valeur unique s'errone
                @grille[i][y]["unique"] = false
                ## La case verifié aussi
                @grille[x][y]["unique"] = false
                cr = false
            end

            ## le bloc est plus petit que la grille
            if(i<3)
                # Verification du block
                for j in 0..2
                    if(block[i][j] == @grille[x][y])
                        ## La valeur unique s'errone
                        @grille[i][j]["unique"] = false
                        ## La case verifié aussi
                        @grille[x][y]["unique"] = false
                        cr = false
                    end
                end
            end
        end

        return cr

    end

    #assets/save/pseudo.yml
end
