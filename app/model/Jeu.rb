class Jeu < Model

  attr_accessor :grille, :chrono, :score
  # @joueur
  # @score
  # @temps
  # @mode

  FACILE=0
  MOYEN=1
  DIFFICILE=2

  def initialize
  	@grille=nil
  	@score=0
    @score_id = 0
  	@chrono =0
  end

  ## Vérification d'une fin de partie, retourne vrai si tout est bon
  ## Doit etre appelé lorsque la grille est pleine
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

  def chargerPartie(pseudo)
    donnees = YAML.load_file(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
    return donnees
  end

  def supprimerPartie(pseudo)

  end
end
