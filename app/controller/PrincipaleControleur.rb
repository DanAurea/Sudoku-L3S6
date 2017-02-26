
##
## @brief      Controleur fenêtre principale
##
class PrincipaleControleur < Controller
	
	def initialize ()
		super()
		## Charge la table utilisateur
		utilisateur = loadModel("utilisateur")
	end

end