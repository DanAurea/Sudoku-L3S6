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

end