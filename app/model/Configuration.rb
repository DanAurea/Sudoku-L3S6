# 	Modele de la configuration
# 	
# 	Author:: 		DanAurea
# 	Developers: 	DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# Declaration de la table contenant les paramètres
#
class Configuration < Model

	def initialize()
		
		## Crée la table configuration
		@@db.execute  "CREATE TABLE IF NOT EXISTS configuration (
						config_id integer primary key autoincrement,
						caseBase varchar(30) NOT NULL,
						caseSelectionne varchar(30) NOT NULL,
						couleurTexte varchar(30) NOT NULL,
						couleurIndices varchar(30) NOT NULL,
						police varchar(50) NOT NULL,
						taillePolice integer NOT NULL,
						utilisateur integer,
						FOREIGN KEY(utilisateur) REFERENCES utilisateur(utilisateur_id)
						);"
	end

end