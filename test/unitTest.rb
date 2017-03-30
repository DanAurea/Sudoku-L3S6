# 	File description
# 	
# 	Author:: 		DanAurea
# 	Developers: 	DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class description
#

require_relative 'grille/grilleCorrecte'
require 'rspec'


class UnitTest
 

	def initialize()
		
	end

	def UnitTest.testerGrilleCorrecte()

		RSpec.describe Generateur, "#grille" do
			it "Generation d'une grille aleatoire" do
				expect(grilleCorrecte()).to eq true
			end
		end
	end

end

puts UnitTest.testerGrilleCorrecte()
