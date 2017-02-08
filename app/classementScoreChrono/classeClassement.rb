include classeScore.rb
class Classement
	#definit par un tableau d'objet de type Score
	#Attribut
	#tableau de score
	#
	attr_accessor :scores 
	def initialize()
		
	end
	def sauvegarderScore()

	end
	def affiche()

		
	end
	def mettreAJour(score)
		# met à jour le score dans le tableau du classement
		self.scores.each{|scorep|

			if (scorep.appartientA == score.appartientA)
			scorep = score		
			end
		}
	end


end