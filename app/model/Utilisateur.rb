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

require Core::ROOT + "model/Configuration.rb"
require Core::ROOT + "model/Score.rb"

class Utilisateur < Model

	def initialize()
		
		## Crée la table utilisateur
		@@db.execute  "CREATE TABLE IF NOT EXISTS utilisateur (
						utilisateur_id integer primary key autoincrement,
						pseudo varchar(30) NOT NULL
						);"

		## Récupère les instances des tables configuration et score (Singleton pattern)
		@configuration = Configuration.instance()
		@score         = Score.instance()
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

		utilisateur_id = @@db.last_insert_row_id
		@configuration.creerConfiguration(utilisateur_id)

		## Crée un score par défaut si mode débug
		## Celà permet de pouvoir tester la création de score 
		## au chargement des utilisateurs.
		if Core::DEBUG
			@score.creerScore(utilisateur_id, 1, 0)
		end

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
		## Faire une jointure sur score etc puis update
	end


	##
	## @brief      Supprime un utilisateur de la base de donnée
	##
	## @param      pseudo  Le pseudo de l'utilisateur a supprimé
	##
	## @return     Retourne vrai si la suppression a eu lieu
	##
	def supprimerUtilisateur(pseudo)
		@@db.execute "DELETE FROM utilisateur WHERE pseudo = ?;", pseudo
	end
	

	##
	## @brief      Recherche un utilisateur dans la bdd
	##
	## @param      pseudo  Le pseudo de l'utilisateur à trouver
	##
	## @return     Retourne 0 si pas trouvé sinon 1
	##
	def rechercherUtilisateur(pseudo)
		resultat = @@db.execute "SELECT pseudo FROM utilisateur WHERE pseudo = ?;", pseudo
		return resultat.length == 1 ? true : false;
	end


	##
	## @brief      Cherche les utilisateur repondant au filtre
	##
	## @param      args  Le filtre à appliquer
	##
	## @return     Les utilisateurs respectant le filtre
	##
	def filtreUtilisateur(**args)
		return self.where(**args)
	end	


	##
	## @brief      Vérifie si un utilisateur a une partie en cours
	##
	## @param      pseudo  Le pseudo de l'utilisateur à vérifier
	##
	## @return     Retourne true si une partie est en cours
	##
	def partieUtilisateur?(pseudo)
		return File.exist?("assets/save"+pseudo)
	end
end