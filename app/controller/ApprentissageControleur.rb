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
class ApprentissageControleur < Controller

	def initialize()
		loadModel("Grille")
		@title  = "Sudoku - Apprentissage"
		@content = {"grille" => nil}
	end

	def run()

		if(@content.has_key?(:niveau))
			niveau = @content[:niveau]
		else
			niveau = 1
		end

		@content["grille"] = @Grille.generer(niveau)
		
		return self
	end

end
