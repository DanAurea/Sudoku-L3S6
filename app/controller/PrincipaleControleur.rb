
##
## @brief      Controleur fenêtre principale
##
class PrincipaleControleur < Controller
	
	def initialize ()
		## Charge la table utilisateur
		loadModel("utilisateur")
	end

	def controllerTest()
		@content["maDonnee"] = "maValeur"
	end

	##
	## @brief      Invoke all methods from controller resulting
	## 				in a sent to view.
	##
	## @return     Itself
	##
	def run()
		self.controllerTest()
		return self
	end

end