#   Modele de la grille
#   
#   Author::        Nikuto
#   Developers:     Nikuto
#   Version::       0.1
#   Copyright::     © 2017
#   License::       Distributes under the same terms as Ruby
#   
    
#   Methodes permettant de manager la grille et de faire des verification
#   de la validité d'une valeurs
require Core::ROOT + "utils/Generateur.rb"

class Grille < Model

    def initialize()
        @grille = nil
    end

    
    ##
    ## @brief      Genere une grille avec un niveau donné
    ##
    ## @param      niveau  Le niveau souhaité
    ##
    ## @return     La grille generée
    ##
    def generer(niveau)
        # Niveau + 1 car constante de 0 à 2 passée en paramètre
        
        @gen = Generateur.new(niveau + 1)
        @grille = @gen.generer()
        
        return @grille
    end

    ##
    ## @brief      Charge la partie du pseudo donnée
    ##
    ## @param      pseudo  Le pseudo du joueur qui charge
    ##
    ## @return     La grille chargée
    ##
    def charger(pseudo)
        donnees = YAML.load_file(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
        @grille=donnees["grille"]
    end

    ##
    ## @brief      Sauvegarde la partie du joueur
    ##
    ## @param      pseudo  Le pseudo du joueur qui sauvegarde
    ##
    ## @return     Retourne vrai quand la sauvegarde s'est fait
    ##
    def sauvegarder(pseudo)
        donnees=Hash.new()
        File.open(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml", "w") do |fichier|
            donnees["grille"] = @grille
            fichier.write(donnees.to_yaml)
        end

        return true
    end

    def getValue(x, y)
        return @grille[x][y]["value"]
    end

    #---------------------------------------------------------------------------
    ## Vérifie à partir de coordonnées que la valeur est unique
    ##
    ## @param      x     Abscisse de la case
    ## @param      y     Ordonnée de la case
    ##
    ## @return     true si la cellule est bien unique false sinon
    ##
    def valeurUnique(valeur, x ,y)
        
        ligneUnique = self.valeurUniqueLigne(valeur, x, y, "ligne")
        colonneUnique =self.valeurUniqueLigne(valeur, x, y, "colonne")

        if(ligneUnique == false || colonneUnique == false)
            return false
        end

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

        ## Parcours la région et vérifie unicité
        for i in 0..2
            for j in 0..2
                ## Case vérifiée exclue
                if(rX + i != x || rY + j != y)
                    if(valeur == self.getValue(rX+i,  rY+j))
                        return false
                    end
                end
            end
        end

        return true
    end
    #-------------------------------------------------------------------------------
    ## Vérifie les valeur d'une ligne en se basant sur des coordonées initial
    ##
    ## @param      x      Ordonnée de la case à verifiée
    ## @param      y      Abscisse de la case à verifiée
    ##
    ## @return     True si valeur unique sinon false
    ##
    def valeurUniqueLigne(valeur, x, y, type)

        ## Parcours ligne ou colonne à la recherche de valeur unique
        if(type == "ligne")

            for i in 0..8
                # On exclue la case vérifiée
                if(i != y)
                    if(valeur == @grille[x][i]["value"])
                        return false
                    end
                end
            end

        else
            
            for i in 0..8
                ## On exclue la case vérifiée
                if(i != x)
                    if(valeur == @grille[i][y]["value"])
                        return false
                    end
                end
            end

        end
        
        return true
    end

end
