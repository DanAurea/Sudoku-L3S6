#   Author::        Nikuto
#   Version::       0.1
#   Copyright::     © 2017
#   License::       Distributes under the same terms as Ruby


##
## Modèle du jeu
##
class Jeu < Model

  attr_accessor :grille, :chrono, :score
  
  ##VI
  @joueur
  @score
  @temps
  @mode

  #Définit le niveau Facile à 0
  FACILE=0
  #Définit le niveau Moyen à 1
  MOYEN=1
  #Définit le niveau Difficile à 2
  DIFFICILE=2

  ##
  ## Initialisation
  ##
  def initialize
  	@grille=nil
  	@score=0
    @score_id = 0
  	@chrono =0
  end

  ## Vérification d'une fin de partie, retourne vrai si tout est bon
  ## Doit etre appelé lorsque la grille est pleine
  ## 
  ## @return  boolean
  def checkFiniPartie()
    ##Parcours la grille pour verifier les valeurs
    for i in 0..8
        for j in 0..8
            if(!Grille.valeurUnique(i,j))
                return false
            end
        end
    end

    return true
  end

  ##
  ## Crée une partie appartenant à un pseudo donné
  ##
  ## @param      pseudo  Le pseudo de l'utilisateur
  ##
  ## @return     true
  ##
  def creerPartie(pseudo)
    donnees=Hash.new()
    File.open(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml", "w") do |fichier|
            donnees["grille"] = @grille
            donnees["score"] = @score
            donnees["chrono"] = @chrono
            fichier.write(donnees.to_yaml)
    end

    return true
  end

  ##
  ## Charge la partie liée au pseudo de l'utilisateur
  ##
  ## @param      pseudo  Le pseudo pour charger la partie
  ##
  ## @return     la partie de l'utilisateur
  ##
  def chargerPartie(pseudo)
    donnees = YAML.load_file(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
    return donnees
  end

  ##
  ## Supprime la partie
  ##
  ## @param      pseudo  The pseudo
  ## 
  def supprimerPartie(_pseudo)

  end
end
