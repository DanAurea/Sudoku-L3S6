require Core::ROOT + "utils/Generateur.rb"  
#   Author::        Nikuto
#   Version::       0.1
#   Copyright::     © 2017
#   License::       Distributes under the same terms as Ruby

##  
##   Méthodes permettant de manager la grille et de faire des vérifications de la validité d'une valeur
##   Modèle de la grille
##
class Grille < Model

    def initialize()
        @grille = nil
    end

    
    ##
    ## Génère une grille avec un niveau donné
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
    ## Charge la partie du pseudo donnée
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
    ## Sauvegarde la partie du joueur
    ##
    ## @param      pseudo  Le pseudo du joueur qui sauvegarde
    ##
    ## @return     Retourne vrai quand la sauvegarde s'est faite
    ##
    def sauvegarder(pseudo)
        donnees=Hash.new()
        File.open(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml", "w") do |fichier|
            donnees["grille"] = @grille
            fichier.write(donnees.to_yaml)
        end

        return true
    end

    ##
    ## Supprime la partie d'un joueur
    ## 
    ## @param       _pseudo     Le pseudo dont on supprime la partie
    ## 
    ## @return true 
    def supprimer(_pseudo)
        return true
    end

    ## Vérifie à partir de coordonnées que la valeur est valide
    ##
    ## @param      x     Abscisse de la case
    ## @param      y     Ordonnée de la case
    ##
    ## @return     true si la cellule est bien unique false sinon
    ##
    def valeurUnique(x ,y)
        ## Le compte rendu de l'inspection
        cr = true

        ## Initialisation pour le parcours du bloc
        block = Array.new()
        x = ((num-1)*3)%9
        y = num/3*3
        grille[x..x+2].each{ |col|
            block << col[y..y+2]
        }
        

        ## Parcours dans [0,8]
        for i in 0..8

            cr = self.VerificationLineaire(x,i,x,y)

            cr = self.VerificationLineaire(i,y,x,y)

            ## le bloc est plus petit que la grille
            if(i<3)
                # Vérification du bloc
                for j in 0..2
                    if(block[i][j]["value"] == @grille[x][y]["value"])
                        ## La valeur unique s'errone
                        @grille[i][j]["unique"] = false
                        ## La case verifiée aussi
                        @grille[x][y]["unique"] = false
                        cr = false
                    end
                end
            end
        end

        return cr

    end

    ## Vérifie les valeurs d'une ligne en se basant sur des coordonées initiales
    ##
    ## @param      x      Ordonnée de la case vérifiée
    ## @param      y      Abscisse de la case vérifiée
    ## @param      xBase  Ordonnée de référence
    ## @param      yBase  Abscisse de référence
    ##
    ## @return     true si la vérification est reussie, false si les cases sont égales
    ##
    def VerificationLineaire(x,y,xBase,yBase)
        ## Verification horizontale
        if(@grille[x][y]["value"] == @grille[xBase][yBase]["value"])
            ## La valeur unique s'errone
            @grille[x][y]["unique"] = false
            ## La case vérifiée aussi
            @grille[xBase][yBase]["unique"] = false
            return false
        end
        return true
    end

end
