#   Author::      PAVARD Valentin
#   Version::     0.1
#   Copyright::   ©
#   License::     Distributes under the same terms as Ruby

##
## @brief      Controleur fenêtre principale
##
class PrincipaleControleur < Controller
	
	def initialize ()
		## Charge la table utilisateur
		loadModel("utilisateur")
	end

	def controllerTest
		puts @content["maDonnee"] = "maValeur"
end

	##
	## @brief      Invoke all methods from controller resulting
	## 				in a sent to view.
	##
	## @return     Itself
	##
	def run()
		return self
	end

end
