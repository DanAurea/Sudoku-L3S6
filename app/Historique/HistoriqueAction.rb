##
## @brief      Classe pour l'historique des actions.
##
class HistoriqueAction
	@pileRefaire
	@pileDefaire
	@maxActions
	@ActionsSave

	##
	## @brief      Méthode qui effectue une action présente dans la pileDefaire
	##
	## @return     lui-même
	##
	def faire()
		action=pileDefaire.pop()
		action.faire()
		return self
	end


	##
	## @brief      Méthode qui annule la dernière action et l'empile dans pileRefaire
	##
	## @return     lui-même
	##
	def defaire()
		action=pileDefaire.pop()
		pileRefaire.push(action)
		action.defaire()
		return self
	end


	##
	## @brief      Méthode qui permet de refaire une action qu'on a annulé
	##
	## @return     lui-même
	##
	def refaire()
		action=pileRefaire.pop()
		pileDefaire.push(action)
		action.faire()
		return self
	end


	##
	## @brief      Fonction d'initialisation
	##
	## @return     { description_of_the_return_value }
	##
	def initialize()
		@pileRefaire=[]
		@pileDefaire=[]
		@maxActions=10
	end


	##
	## @brief      Ajoute une nouvelle fonction dans la pileDefaire
	##
	## @param      action  L'action à ajouter
	##
	## @return     lui-même
	##
	def nouvelleAction(action)
		@pileDefaire.push(action)
		return self
	end

	##
	## @brief      Défait une action
	##
	## @return     L'action dépilée
	##
	def defaireAction()
		action=@pileDefaire.pop
		@pileRefaire.push(action)
		return action
	end
end