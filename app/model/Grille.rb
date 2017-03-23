require Core::ROOT + "utils/Generateur.rb"

class Grille < Model

    def initialize()
        @gen = Generateur.new()
    end

    def generer(niveau)
        return @gen.generer(niveau)
    end

    def charger(pseudo)
        #return grille
    end

    def sauvegarder(pseudo)
        return true
    end

    def supprimer(pseudo)
        return true
    end

end