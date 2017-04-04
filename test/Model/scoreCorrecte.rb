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



def checkCreaScore(usr, sco)
	score = sco.calcul(2, 120)
	creerScore(1, 0, score)
	if (!meilleursScores(1))
		return false
	end
	return true
end




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
