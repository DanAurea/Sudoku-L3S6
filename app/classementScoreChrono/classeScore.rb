class Score
	#definit l'objet Score, lié à un entier et à un nom d'utilisateur
	#
	#Attribut
	#
	attr_accessor :valeur
	attr_reader :nom_utilisateur

	# méthodes
	# 
	def initialize()
		
	end
	def penalite()
		
	end
	def gain()
		
	end
	def appartientA()
		# retourne le nom de l'utilisateur qui a ce score
		# 
		return self.nom_utilisateur
		
	end



end