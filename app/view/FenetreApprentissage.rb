# 	File description
# 	
# 	Author:: 		Valentin, DanAurea
# 	Developers: 	Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreApprentissage < View

	def initialize()
		
	end

	##
	## @brief     Lance la construction du modèle
	## 			  de la vue.
	## 			  Méthode à définir dans tout les cas !
	## 			  Autrement pas de rendu de la page.
	##
	## @return     itself
	##
	def run()
		Fenetre::css(:chemin => "/assets/css/FenetreApprentissage.css")
		return self
	end

end
