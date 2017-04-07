#   Author::        Nikuto
#   Version::       0.1
#   Copyright::     © 2017
#   License::       Distributes under the same terms as Ruby


##
## Modèle du jeu
##
class Jeu < Model
  ##VI
  attr_accessor :grille, :chrono, :score

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
    @grille   =nil
    @score    =0
    @score_id =0
    @chrono   =0
    @niveau   =1
  end

  ##
  ## Crée une partie appartenant à un pseudo donné au format YAML
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
    donnees["niveau"] = @niveau
    fichier.write(donnees.to_yaml)

    return self
  end

  ##
  ## Charge la partie liée au pseudo de l'utilisateur
  ##
  ## @param      pseudo  Le pseudo de l'utilisateur
  ##
  ## @return     la partie de l'utilisateur
  ##
  def chargerPartie(pseudo)
    donnees = YAML.load_file(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
    return donnees
  end

  ##
  ## Supprime la partie d'un utilisateur précis
  ##
  ## @param     pseudo  The pseudo
  ## 
  ## @return    true si supprimé, false sinon
  ## 
  def supprimerPartie(pseudo)
    return File.delete(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
  end

end
