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
        donnees = YAML.load_file(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
        @grille=donnees["grille"]
    end

    def sauvegarder(pseudo)
        donnees=Hash.new()
        File.open(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml", "w") do |fichier|
            donnees["grille"] = @grille
            fichier.write(donnees.to_yaml)
        end

        return true
    end

    def supprimer(pseudo)
        return true
    end

    ## Retourne vrai si la cellule est bien unique
    def valeurUnique(x ,y)
        ## Le compte rendu de l'inspection
        cr = true

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
        end

        return cr

    end

    #assets/save/pseudo.yml
end
