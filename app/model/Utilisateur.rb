# 	Modele utilisateur
# 	
# 	Author:: 		Nikuto
# 	Developers: 	Nikuto
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class d'administration des utilisateurs
#
class Utilisateur < Model


	def initialize()
		
		## Crée la table utilisateur
		@@db.execute  "CREATE TABLE IF NOT EXISTS utilisateur (
						id integer primary key autoincrement,
						pseudo varchar(30)
						);"
	end

	##
	## @brief      Ajoute un utilisateur dans la base de données
	##
	## @param      pseudo  Le pseudo de l'utilisateur
	##
	## @return     Retourne l'utilisateur crée
	##
	def creerUtilisateur(pseudo)
		insert(:pseudo => pseudo)
		return self
	end

	##
	## @brief      Mise a jour d'un utilisateur dans la base donnée
	##
	## @param      args  Les paramètres a mettre à jour
	##
	## @return     Retourne l'utilisateur modifié
	##
	def majUtilisateur(**args)
		self.update(args)
	end


	##
	## @brief      Supprime un utilisateur de la base de donnée
	##
	## @param      pseudo  Le pseudo de l'utilisateur a supprimé
	##
	## @return     Retourne vrai si la suppression a ue lieu
	##
	def supprimerUtilisateur(pseudo)
		if self.where(pseudo: pseudo).delete(1) != nil
			return true
		else
			return false
		end
	end
	

	##
	## @brief      Recherche un utilisateur dans la bdd
	##
	## @param      pseudo  Le pseudo de l'utilisateur à trouver
	##
	## @return     Retourne ce qui a été trouver
	##
	def rechercherUtilisateur(pseudo)
		return self.find_by(pseudo: pseudo)
	end


	##
	## @brief      Cherche les utilisateur repondant au filtre
	##
	## @param      args  Le filtre a appliqué
	##
	## @return     Les utilisateurs respectant le filtre
	##
	def filtreUtilisateur(**args)
		return self.where(**args)
	end	


	##
	## @brief      Vérifie si un utilisateur a une partie en cours
	##
	## @param      pseudo  Le pseudo de l'utilisateur à vérifié
	##
	## @return     Retourne true si une partie est en cours
	##
	def partieUtilisateur?(pseudo)
		return File.exist?("assets/save"+pseudo)
	end
end