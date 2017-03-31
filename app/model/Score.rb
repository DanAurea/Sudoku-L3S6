class Score < Model

	def initialize()
		
		## Crée la table Score
		@@db.execute  "CREATE TABLE IF NOT EXISTS score (
						score_id integer primary key autoincrement,
						niveau integer NOT NULL,
						score integer NOT NULL,
						utilisateur integer,
						FOREIGN KEY(utilisateur) REFERENCES utilisateur(utilisateur_id)
						);"
	end


	##
	## Crée un score dans la table score pour l'utilisateur
	##
	## @param      utilisateurId  L'identifiant utilisateur
	##
	## @return     Self
	##
	def creerScore(utilisateurId, niveau, score)


		insert(:utilisateur => utilisateurId, :niveau => niveau, :score => score)

		return self
	end

end