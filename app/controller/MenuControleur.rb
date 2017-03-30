
class MenuControleur < Controller

	def initialize
		loadModel("Utilisateur")
		@title = "Sudoku - Menu"
		@width = 600
		@height = 550
		@resizable = false
		@position= "CENTER_ALWAYS"
	end

	def partieExiste(pseudo)
		return @Utilisateur.partieUtilisateur?(pseudo)
	end

	def run
		return self
	end
end
