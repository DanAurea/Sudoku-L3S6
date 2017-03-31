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


	##
	## Calcule le score du joueur
	##
	## @param      penalite     Nombre de pénalités
	## @param      tempsChrono  L'état du chrono
	##
	## @return     Score de l'utilisateur
	##
	def calculScore(penalite, tempsChrono)
		tempsResoluMoy = 3*60
		difficulte = 2
		evolutionScore = (tempsResoluMoy - tempsChrono) + ((tempsResoluMoy/10)*(20 - penalite))
		scoreCourant = self.valeur + (difficulte*evolutionScore)
		self.valeur = scoreCourant
		return scoreCourant
	end

end