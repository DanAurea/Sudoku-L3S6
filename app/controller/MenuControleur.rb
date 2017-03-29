
class MenuControleur < Controller

	def initialize
		@title = "Sudoku - Menu"
		loadModel("Utilisateur")
	end

	def partieExiste(pseudo)
		return @Utilisateur.partieUtilisateur?(pseudo)
	end

	def run
		return self
	end
end
