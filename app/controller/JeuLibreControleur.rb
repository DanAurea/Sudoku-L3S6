# 	File description
# 	
# 	Author:: 		DanAurea
# 	Developers: 	DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Contrôle le déroulement du jeu libre
#
class JeuLibreControleur < Controller

	def initialize()
		loadModel("Grille")
		@title  = "Sudoku - Jeu Libre"
		@content = {"grille" => nil}
	end

	def run()

		if(@content.has_key?("difficulte"))
			niveau = @content["difficulte"]
		else
			niveau = 1
		end

		@content["grille"] = @Grille.generer(niveau)
		
		return self
	end

end