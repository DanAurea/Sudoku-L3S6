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



def checkCreation(usr)
	usr.creerUtilisateur("toto")
	return rechercherUtilisateur("toto")
end

def checkSupression(usr)
	supprimerUtilisateur
	return !rechercherUtilisateur("toto")
end



def utilisateurCorrecte()
	

	usr = Utilisateur.new()


	if(!checkCreation(usr))
		return false
	end

	if(!checkSupression(usr))
		return false
	end


	puts "all green"
	return true
end


