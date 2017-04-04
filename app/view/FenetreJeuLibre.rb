# => Contient la classe FenetreJeuLibre
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetreJeuLibre
##

require Core::ROOT + "components/GrilleDessin.rb"
require "observer"

class FenetreJeuLibre < View
	include Observable

	##
	## Initialize
	##
	##
	def initialize()
		Header::chrono

		@contenu      = Gtk::Box.new(:horizontal, 0)
		@grilleDessin = nil
		@scoreLabel   = nil
	end

	def update(x, y, value)
		updateGrille(x, y, value)
	end

	##
	## Crée le dessin de la grille
	##
	## @return     Self
	##
	def creerGrille()
		@grilleDessin = GrilleDessin.new(@grille)
		@grilleDessin.add_observer(self)

		return self
	end

	##
	## Met en place tout les éléments sur la page
	##
	## @return     { description_of_the_return_value }
	##
	def miseEnPlace()
		@contenu.add(@grilleDessin)

		Fenetre::box.add(@contenu)
	end

	##
	## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
	##
	## @return self
	##
	def run()
		self.creerGrille()
		self.miseEnPlace()
		Fenetre::css(:chemin => "/assets/css/FenetreJeuLibre.css")
		return self
	end
end
