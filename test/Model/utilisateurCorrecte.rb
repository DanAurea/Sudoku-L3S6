# 	File description
# 	
# 	Author:: 		BastienMor
# 	Developers: 	BastienMor
# 	Version:: 		0.1
# 	Copyright:: 	© 2017
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class description
# 	Classe de test unitaire de l'utilisateur.
require_relative '../../app/model/Utilisateur'



##
## Creer un utilisateur et le recherche pour vérifié son existance.
##
## @param usr l'objet utilisateur.
##
## @return true si l'utilisateur a bien été creer, false sinon.
##

def checkCreation(usr)
	usr.creerUtilisateur("toto")
	return rechercherUtilisateur("toto")
end


##
## Supprime un utilisateur et le recherche pour vérifié son inexistance.
##
## @param usr l'objet utilisateur.
##
## @return true si l'utilisateur a bien été supprimer, false sinon.
##

def checkSupression(usr)
	supprimerUtilisateur
	return !rechercherUtilisateur("toto")
end

##
## méthode de test, génère un utilisateur et vérifi qu'il existe et qu'on peut le supprimer.
##
## @return true si l'utilisateur foncrionne, false sinon.
##

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


