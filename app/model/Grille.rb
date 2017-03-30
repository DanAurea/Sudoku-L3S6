require Core::ROOT + "utils/Generateur.rb"

class Grille < Model

    def initialize()
        @gen = Generateur.new()
        @grille = nil
    end

    ## Genere une grille avec une difficulté donnée
    def generer(niveau)
        @grille = @gen.generer(niveau)
        return @grille
    end

    ## Charge la partie du pseudo donnée
    def charger(pseudo)
        donnees = YAML.load_file(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
        @grille=donnees["grille"]
    end

    ## Sauvegarde la partie du joueur
    def sauvegarder(pseudo)
        donnees=Hash.new()
        File.open(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml", "w") do |fichier|
            donnees["grille"] = @grille
            fichier.write(donnees.to_yaml)
        end

        return true
    end

    ## TODO
    ## Supprime la partie d'un joueur
    def supprimer(pseudo)
        return true
    end

    ## Vérifie a partir de coordonné que la valeur est valide
    ## @return vrai si la cellule est bien unique
    def valeurUnique(x ,y)
        ## Le compte rendu de l'inspection
        cr = true

        ## Initialisation pour le parcours du block
        block = Array.new()
        x = ((num-1)*3)%9
        y = num/3*3
        grille[x..x+2].each{ |col|
            block << col[y..y+2]
        }
        

        ## Parcours dans [0,8]
        for i in 0..8

            ## Verification horizontale
            if(@grille[x][i]["value"] == @grille[x][y]["value"])
                ## La valeur unique s'errone
                @grille[x][i]["unique"] = false
                ## La case verifié aussi
                @grille[x][y]["unique"] = false
                cr = false
            end

            ## Verification verticale
            if(@grille[i][y]["value"] == @grille[x][y]["value"])
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
                    if(block[i][j]["value"] == @grille[x][y]["value"])
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
