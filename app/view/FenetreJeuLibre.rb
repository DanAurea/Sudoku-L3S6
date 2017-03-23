#   Fenetre jeu libre
#
# 	Author:: 		Valentin, DanAurea
# 	Developers: 	Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	


class FenetreJeuLibre < View

	def initialize()
		require Core::ROOT + "components/GrilleDessin.rb"
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

		grilleDessin = GrilleDessin.new(@grille)

		Fenetre::table.attach(grilleDessin,0,10,0,12)
		Fenetre::css(:chemin => "/assets/css/FenetreJeuLibre.css")
		return self
	end

end
