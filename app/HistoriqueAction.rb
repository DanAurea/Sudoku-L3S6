

class HistoriqueAction

	@pileRefaire
	@pileDefaire
	@maxActions
	@ActionsSave

	def faire()
		action=pileDefaire.pop()
		action.faire()
	end

	def defaire()
		action=pileDefaire.pop()
		pileRefaire.push(action)
		action.defaire()
	end

	def refaire()
		action=pileRefaire.pop()
		pileDefaire.push(action)
		action.faire()
	end

	def initialize()
		@pileRefaire=[]
		@pileDefaire=[]
		@maxActions=10
	end

	def nouvelleAction(action)
		@pileDefaire.push(a)
	end

	def defaireAction()
		act=@pileDefaire.pop
		@pileRefaire.push(act)
		return act
	end

end