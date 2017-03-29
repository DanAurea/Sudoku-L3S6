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
class ScoresControleur < Controller

	def initialize()
		loadModel("Utilisateur")
		@title = "Sudoku - Scores"
		@width = 600
		@height = 550
		@resizable = false
	end

	def run()
		return self
	end

end
