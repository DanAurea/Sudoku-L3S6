# 	File description
# 	
# 	Author:: 		BastienMor
# 	Developers: 	BastienMor
# 	Version:: 		0.1
# 	Copyright:: 	© 2017
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class description
# 	Classe de test unitaire du score de la partie.

require_relative '../../app/model/Utilisateur'
require_relative '../../app/model/Score'


##
## Creer un score et le recherche pour vérifié son existance.
##
## @param usr l'objet utilisateur et sco l'objet score.
##
## @return true si le score a bien été creer, false sinon.
##

def checkCreaScore(usr, sco)
	score = sco.calcul(2, 120)
	creerScore(1, 0, score)
	if (!meilleursScores(1))
		return false
	end
	return true
end


##
## méthode de test, génère un utilisateur et vérifi que l'on peu creer des scores a lui associé.
##
## @return true si le score foncrionne, false sinon.
##
def scoreCorrecte()
	

	usr = Utilisateur.new()
	sco = Score.new()
	usr.creerUtilisateur("toto")


	if(!checkCreaScore(usr, sco))
		return false
	end

	puts "all green"
	return true
end
