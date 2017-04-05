load "Action.rb"

## => Author:: 		keryann
## => version:: 	0.1
## => copyright:: 	© 2016
## => license:: 	Distributes under the same terms as Ruby

##
## Classe pour l'historique des actions.
##--
## Regarder slice-1 pour enlever bas de la pile
##++
class HistoriqueAction
	##VI
	@pileRefaire
	@pileDefaire
	@maxActions

	##
	## Méthode qui effectue une action présente dans la pileDefaire
	##
	## @return 	lui-même
	##
	def faire()
		action=@pileDefaire.last()
		action.faire()
		return self
	end


	##
	## Méthode qui annule la dernière action et l'empile dans pileRefaire
	##
	## @return lui-même
	##
	def defaire()
		@pileRefaire.push(@pileDefaire.pop())
		action=@pileDefaire.last()
		action.faire()
		return self
	end


	##
	## Méthode qui permet de refaire une action qu'on a annulé
	##
	## @return 	lui-même
	##
	def refaire()
		@pileDefaire.push(@pileRefaire.pop())
		action=@pileDefaire.last()
		action.faire()
		return self
	end


	##
	## Fonction d'initialisation
	##
	def initialize()
		@pileRefaire=[]
		@pileDefaire=[]
		@maxActions=10
	end


	##
	## Ajoute une nouvelle fonction dans la pileDefaire
	##
	## @param 	action 			L'action à ajouter
	##
	## @return 	lui-même
	##
	def nouvelleAction(action)
		@pileDefaire.push(action)
		return self
	end

	##
	## Défait une action
	##
	## @return 	L'action dépilée
	##
	def defaireAction()
		action=@pileDefaire.pop
		@pileRefaire.push(action)
		return action
	end


	##
	## Fonction de test   
	##
	def HistoriqueAction.Test()
		histo=HistoriqueAction.new()
		act1=Action.new("Premiere action")
		act2=Action.new("Deuxieme action")
		#act3=Action.new("Troisieme action")
		#act4=Action.new("Quatrieme action")
		#act5=Action.new("Cinquieme action")
		histo.nouvelleAction(act1)
		histo.nouvelleAction(act2)
		#histo.nouvelleAction(act3)
		#histo.nouvelleAction(act4)
		#histo.nouvelleAction(act5)
		histo.faire()
		print("\n")
		histo.defaire()
		print("\n")
		histo.refaire()
	end
end

HistoriqueAction.Test()