class Jeu < Model

  @grille
  @joueur
  @score
  @temps
  @mode

  ## Vérification d'une fin de partie, retourne vrai si tout est bon
  ## Doit etre appelé lorsque la grille est pleine
  def checkFiniPartie()
    ##Parcours la grille pour verifier les valeurs
    for i in 0..8
        for j in 0..8
            if(@grille[i][j]["value"]==nil || !Grille.valeurUnique(i,j))
                return false
            end
        end
    end

    return true
  end

  def creerPartie(pseudo,diff,mode)

  end

  def chargerPartie(pseudo)

  end

  def supprimerPartie(pseudo)

  end
