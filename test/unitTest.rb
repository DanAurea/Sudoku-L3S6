# 	File description
# 	
# 	Author:: 		DanAurea
# 	Developers: 	DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class description
# 	Classe de test unitaire des différents modules.

require_relative "../app/core/Core.rb"
require_relative "../app/core/Model.rb"
require_relative 'Generateur/grilleCorrecte'
require_relative 'Model/utilisateurCorrecte'
require_relative 'Model/scoreCorrecte'
#require 'rspec'


class UnitTest
 

	def initialize()
		
	end

	
	##
	## méthode de test du générateur de grille.
	##
	## @return true si le test est positif, false sinon.
	##

	def UnitTest.testerGrilleCorrecte()

		grilleCorrecte()

		#RSpec.describe Generateur, "#grille" do
		#	context "test" do
		#		it "Generation d'une grille aleatoire" do
		#			expect(grilleCorrecte()).to eq false
		#		end
		#	end
		#end
	end


	##
	## méthode de test du gestionnaire d'utilisateurs.
	##
	## @return true si le test est positif, false sinon.
	##

	def UnitTest.testerUtilisateurCorrecte()
		return utilisateurCorrecte()
	end


	##
	## méthode de test de la gestion des scores.
	##
	## @return true si le test est positif, false sinon.
	##

	def UnitTest.testerScoreCorrecte()
		if(utilisateurCorrecte())
			scoreCorrecte()
		else
			return false
		end
	end



end

puts UnitTest.testerGrilleCorrecte()
puts UnitTest.testerUtilisateurCorrecte()
puts UnitTest.testerScoreCorrecte()





