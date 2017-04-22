require Core::ROOT + "model/Configuration.rb"
require Core::ROOT + "model/Score.rb"
require Core::ROOT + "model/Jeu.rb"

## 	Author:: 		Nikuto, DanAurea
## 	Developers: 	Nikuto, DanAurea
## 	Version:: 		0.1
## 	Copyright:: 	© 2016
## 	License::   	Distributes under the same terms as Ruby
## 	

##	
##	Classe d'administration des utilisateurs
##	Modèle utilisateur
##
class Utilisateur < Model

	##
	## Initialisation
	##
	def initialize()
		
		## Crée la table utilisateur
		@@db.execute "CREATE TABLE IF NOT EXISTS utilisateur (
						utilisateur_id integer primary key autoincrement,
						pseudo varchar(30) NOT NULL
						);"

		## Récupère les instances des tables configuration et score (Singleton pattern)
		@configuration = Configuration.instance()
		@score         = Score.instance()
		@jeu           = Jeu.instance()
	end

	##
	## Ajoute un utilisateur dans la base de données
	##
	## @param      pseudo  Le pseudo de l'utilisateur
	##
	## @return     Retourne l'utilisateur créé
	##
	def creerUtilisateur(pseudo)
		insert(:pseudo => pseudo)

		@configuration.creerConfiguration(pseudo)

		## Crée un score par défaut si mode débug
		## Cela permet de pouvoir tester la création de score 
		## au chargement des utilisateurs.
		if Core::DEBUG
			@score.creer(pseudo, Jeu::FACILE, 600)
		end

		return self
	end

	##
	## Supprime un utilisateur de la base de données
	##
	## @param      pseudo  Le pseudo de l'utilisateur à supprimer
	##
	## @return     Retourne vrai si la suppression a eu lieu
	##
	def supprimerUtilisateur(pseudo)
		@@db.execute "DELETE FROM utilisateur WHERE pseudo = ?;", pseudo
	end

	##
	## Supprime tout les scores de l'utilisateur
	##
	## @param      pseudo  Pseudo de l'utilisateur
	##
	##
	def reinitialiserUtilisateur(pseudo)
		## Récupère id utilisateur
		req = @@db.execute "SELECT utilisateur_id FROM utilisateur WHERE pseudo= ?", pseudo

		utilisateur_id = req[0][0][0]

		if(req.length > 0)
			@@db.execute "DELETE FROM score WHERE utilisateur= ?", utilisateur_id
			@@db.execute "DELETE FROM configuration WHERE utilisateur = ?", utilisateur_id
			@configuration.creerConfiguration(pseudo)
		end

		if(self.partieUtilisateur?(pseudo))
			@jeu.supprimerPartie(pseudo)
		end
	end

	##
	## Recherche un utilisateur dans la base de données
	##
	## @param      pseudo  Le pseudo de l'utilisateur à trouver
	##
	## @return     Retourne 0 si pas trouvé sinon 1
	##
	def rechercherUtilisateur(pseudo)
		resultat = @@db.execute "SELECT pseudo FROM utilisateur WHERE pseudo = ? LIMIT 1;", pseudo
		return resultat.length >= 1 ? true : false;
	end

	##
	## Vérifie si un utilisateur a une partie en cours
	##
	## @param      pseudo  Le pseudo de l'utilisateur à vérifier
	##
	## @return     Retourne true si une partie est en cours
	##
	def partieUtilisateur?(pseudo)
		return File.exist?(Core::ROOTPROJECT + "assets/save/" + pseudo + ".yml")
	end
end
