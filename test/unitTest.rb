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

require_relative 'grille/grilleCorrecte'
require 'rspec'


class UnitTest
 

	def initialize()
		
	end

	def UnitTest.testerGrilleCorrecte()

		RSpec.describe Generateur, "#grille" do
			context "test" do
				it "Generation d'une grille aleatoire" do
					expect(grilleCorrecte()).to eq false
				end
			end
		end
	end

end

puts UnitTest.testerGrilleCorrecte()
