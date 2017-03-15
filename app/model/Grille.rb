require Core::ROOT+"generateur/Generateur.rb"

class Grille < Model

  def generateurGrille(niveau)
    gen = Generateur.new()
    return gen.generer(niveau)
  end

  def chargerGrille(pseudo)
    #return grille
  end

  def sauvegarderGrille(pseudo)
    return true
  end

  def supprimerGrille(pseudo)
    return true
  end

end

# Utilisateur.yml dans assets/save
#print("hello")
#grille = Grille.new()
#grille.generateurGrille(1)