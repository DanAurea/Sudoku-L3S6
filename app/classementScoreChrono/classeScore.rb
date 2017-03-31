class Score
	#definit l'objet Score, lié à un entier et à un nom d'utilisateur
	#
	#Attribut
	#
	attr_accessor :valeur
	attr_reader :nom_utilisateur

	# méthodes
	# 
	#private method :new
	private

	def initialize(nom)
		@valeur = 0
		@nom_utilisateur= nom
	end


	public
	
	def score(nom)
		scoreJD = Score.new(nom)
		return scoreJD
	end

	def appartientA()
		# retourne le nom de l'utilisateur qui a ce score
		# 
		return self.nom_utilisateur
	end
	
	def calculScore(penalite, tempsChrono)
		tempsResoluMoy = 3*60
		difficulte = 2
		evolutionScore = (tempsResoluMoy - tempsChrono) + ((tempsResoluMoy/10)*(20 - this.penalite))
		scoreCourant = self.valeur + (difficulte*evolutionScore)
		self.valeur = scoreCourant
		return scoreCourant
	end
end
atScore = Score.new('alext')
puts " score de #{atScore.nom_utilisateur} : #{atScore.valeur} pts"
atScore = atScore.calculScore(22, 120)
puts " score de #{atScore.nom_utilisateur} : #{atScore.valeur} pts apres nouveau score"
