# => Contient la classe FenetreCharger
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreCharger
##
class FenetreCharger < View

	##
	## Initialize
	##
	##
	def initialize()
		require Core::ROOT + "components/GrilleDessin.rb"
	end

	##
	## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
	##
	## @return self
	##
	def run()
		grilleDessin = GrilleDessin.new(@grille)
		Fenetre::box.add(grilleDessin)
		return self
	end
end
