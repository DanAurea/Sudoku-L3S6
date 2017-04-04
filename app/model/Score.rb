class Score < Model

	def initialize()
		
		## Crée la table Score
		@@db.execute "CREATE TABLE IF NOT EXISTS score (
						score_id integer primary key autoincrement,
						niveau integer NOT NULL,
						score integer NOT NULL,
						utilisateur integer,
						FOREIGN KEY(utilisateur) REFERENCES utilisateur(utilisateur_id)
						);"
		@difficulte = 0
	end

	##
	## Récupère les scores de l'utilisateur
	##
	## @param      pseudo  Pseudo de l'utilisateur
	##
	## @return     Les scores (tableau de hash)
	##
	def scoreUtilisateur(pseudo)
		req = @@db.execute2 "SELECT * FROM utilisateur INNER JOIN score ON utilisateur=utilisateur_id WHERE pseudo=?;", pseudo
		return self.to_h(req)
	end

	##
	## Récupère les n meilleures scores
	##
	## @param      n     Nombre de scores à récupérer
	##
	## @return     Les scores (tableau de hash)
	##
	def meilleursScores(n)
		req = @@db.execute2 "SELECT * FROM utilisateur INNER JOIN score ON utilisateur=utilisateur_id ORDER BY score DESC LIMIT ?;", n

		return self.to_h(req)
	end

	##
	## Crée un score dans la table score pour l'utilisateur
	##
	## @param      utilisateurId  L'identifiant utilisateur
	##
	## @return     Self
	##
	def creer(utilisateurId, niveau, score)

		insert(:utilisateur => utilisateurId, :niveau => niveau, :score => score)

		return self
	end

	##
	## Met à jour le score d'un utilisateur
	##
	## @return     { description_of_the_return_value }
	##
	def mettreAJour(score_id, score)
		@@db.execute "UPDATE score SET score= ? WHERE score_id = ?", score, score_id
	end

	##
	## Calcule le score du joueur
	##
	## @param      penalite     Nombre de pénalités
	## @param      tempsChrono  L'état du chrono
	##
	## @return     Score de l'utilisateur
	##
	def calcul(penalite, tempsChrono)
		
		tempsResoluMoy = 3*60

		evolutionScore = (tempsResoluMoy - tempsChrono) + ((tempsResoluMoy/10)*(20 - penalite))
		scoreCourant = (@difficulte+1)*evolutionScore
		
		return scoreCourant
	end

end
