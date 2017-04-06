class Jeu < Model

	attr_accessor :grille, :chrono, :score, :niveau
	# @joueur
	# @score
	# @temps
	# @mode

	FACILE=0
	MOYEN=1
	DIFFICILE=2

	def initialize
		@grille   =nil
		@score    =0
		@score_id = 0
		@chrono   =0
		@niveau   = 1
	end

	##
	## Crée une partie au format YAML pour la partie
	##
	## @param      pseudo  Pseudo utilisateur
	##
	## @return     self
	##
	def creerPartie(pseudo)
		donnees=Hash.new()
		File.open(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml", "w") do |fichier|
		donnees["grille"] = @grille
		donnees["score"] = @score
		donnees["chrono"] = @chrono
		donnees["niveau"] = @niveau
		fichier.write(donnees.to_yaml)

		return self
	end

	return true
	end

	##
	## Charge une partie d'un utilisateur précis.
	##
	## @param      pseudo  Pseudo de l'utilisateur
	##
	## @return     Données chargées
	##
	def chargerPartie(pseudo)
		donnees = YAML.load_file(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
		return donnees
	end

	##
	## Supprime la partie d'u utilisateur précis
	##
	## @param      pseudo  Pseudo de l'utilisateur
	##
	## @return     true si supprimé sinon false
	##
	def supprimerPartie(pseudo)
		return File.delete(Core::ROOTPROJECT + "assets/save/" + pseudo.to_s + ".yml")
	end
end
