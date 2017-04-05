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
	## VI
	@menuBarre
	@boxMilieu
	@boxGrille
	@grilleDessin
	@scoreLabel

	##
	## Initialize
	##
	##
	def initialize()
		Header::chrono

		@menuBarre=Fenetre::creerBarreMenu()
		@boxMilieu = Gtk::Box.new(:horizontal, 0)
		@boxGrille = Gtk::Box.new(:horizontal, 0)
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
	##
	def miseEnPlace()
		#barre de menu
		gestionBarreMenu()

		#box grille
		@boxGrille.add(@grilleDessin)

		@boxMilieu.add(@boxGrille)

		#add a la box
		Fenetre::box.add(@menuBarre)
		Fenetre::box.add(@boxMilieu)
	end

	##
	## Met en place la barre de menu
	##
	## 
	##
	def gestionBarreMenu()
		Fenetre::boutonMenu_barre.signal_connect('clicked'){
			messageQuestion = Fenetre::creerPopup("1/2: Voulez-vous vraiment abandonner la partie et revenir au menu principal?", "YES_NO")
		    if(messageQuestion.run() == Gtk::ResponseType::YES)
		    	messageQuestion2 = Fenetre::creerPopup("2/2: Voulez-vous sauvegarder la partie actuelle?", "YES_NO")
		    	if(messageQuestion2.run() == Gtk::ResponseType::YES)
		    		sauvegarder()
		    	end
		    	Core::changeTo("Menu", "pseudo": @pseudo)
		    	messageQuestion2.destroy()
		    end
		    messageQuestion.destroy()
		}
		Fenetre::boutonSauvegarder_barre.signal_connect('clicked'){
			sauvegarder()
		}
		Fenetre::boutonReinit_barre.signal_connect('clicked'){
			
		}
		Fenetre::boutonQuitter_barre.signal_connect('clicked'){
			messageQuestion = Fenetre::creerPopup("1/2: Voulez-vous vraiment abandonner la partie et quitter l'application?", "YES_NO")
		    if(messageQuestion.run() == Gtk::ResponseType::YES)
		    	messageQuestion2 = Fenetre::creerPopup("2/2: Voulez-vous sauvegarder la partie actuelle?", "YES_NO")
		    	if(messageQuestion2.run() == Gtk::ResponseType::YES)
		    		sauvegarder()
		    	end
		    	Fenetre::detruire()
		    	messageQuestion2.destroy()
		    end
		    messageQuestion.destroy()
		}
		Fenetre::boutonPauseChrono_barre.signal_connect('clicked'){
			Header::pause = true
		}
		Fenetre::boutonPlayChrono_barre.signal_connect('clicked'){
			Header::pause = false
		}
		Fenetre::boutonAnnuler_barre.signal_connect('clicked'){

		}
		Fenetre::boutonRetablir_barre.signal_connect('clicked'){

		}
	end

	##
	## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
	##
	## @return self
	##
	def run()
		self.creerGrille()
		self.miseEnPlace()
		return self
	end
end
