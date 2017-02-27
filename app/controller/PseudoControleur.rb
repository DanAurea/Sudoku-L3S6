##
##	@brief Controleur de la fenetre de pseudo
##

class PseudoControleur < Controller
	
	def initialize()
		## Charge le modele utilisateur
		loadModel("Utilisateur")
	end

	def profil(pseudo)
		##Remplir le content d'info
		@content["profil"]=@Utilisateur.rechercheUtilisateur(pseudo)
	
	end

	def pseudoExiste(pseudo)

		if @Utilisateur.existe?(pseudo)
			return true
		else
			return false
		end

	end

	def run()
		
		return self	
	end

end
