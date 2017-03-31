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
	
	CL_CASE_BASE        = ["65535", "65535", "65535"]
	CL_CASE_FIXE        = ["61500", "61500", "61500"]
	CL_CASE_SELECTIONNE = ["0", "50000", "50000"]
	CL_INDICES          = ["0", "32000", "65535"]
	CL_TEXTE			= ["0", "0", "0"]
	POLICE              = "Sans Regular"
	TAILLE_POLICE		= 12

	def initialize()
		
		## Crée la table configuration
		@@db.execute  "CREATE TABLE IF NOT EXISTS configuration (
						config_id integer primary key autoincrement,
						caseBase varchar(30) NOT NULL,
						caseFixe varchar(30) NOT NULL,
						caseSelectionne varchar(30) NOT NULL,
						couleurTexte varchar(30) NOT NULL,
						couleurIndices varchar(30) NOT NULL,
						police varchar(50) NOT NULL,
						taillePolice integer NOT NULL,
						utilisateur integer,
						FOREIGN KEY(utilisateur) REFERENCES utilisateur(utilisateur_id)
						);"
	end


	##
	##  Crée une configuration par défaut pour l'utilisateur
	##
	## @param      utilisateurId  L'identifiant utilisateur
	##
	## @return     Self
	##
	def creerConfiguration(utilisateurId)
		params = Hash.new()

		params[:caseBase] = Configuration::CL_CASE_BASE.join(",")
		params[:caseFixe] = Configuration::CL_CASE_FIXE.join("")
		params[:caseSelectionne] = Configuration::CL_CASE_SELECTIONNE.join("")
		params[:couleurTexte] = Configuration::CL_TEXTE.join(",")
		params[:couleurIndices] = Configuration::CL_INDICES.join(",")
		params[:police] = Configuration::POLICE
		params[:taillePolice] = Configuration::TAILLE_POLICE
		params[:utilisateur] = utilisateurId

		insert(params)
		
		return self
	end

end