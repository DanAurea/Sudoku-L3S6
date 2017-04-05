# => Contient la classe FenetreApprentissage pour la fenêtre du menu apprentissage
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

require Core::ROOT + "components/GrilleDessin.rb"

class FenetreApprentissage < View
	## VI
	@menuBarre
	@boxMilieu
	@boxGrille
	@boxInfo
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
		@boxInfo = Gtk::Box.new(:vertical, 0)
		@grilleDessin = nil
		@scoreLabel   = nil
	end

	##
	## Crée le dessin de la grille
	##
	## @return     Self
	##
	def creerGrille()
		@grilleDessin = GrilleDessin.new(@grille)
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

		#box de droite
		gestionDroite()

		@boxMilieu.add(@boxGrille)
		@boxMilieu.add(@boxInfo)

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
			Core::changeTo("Menu", "pseudo": @pseudo)
		}
		Fenetre::boutonSauvegarder_barre.signal_connect('clicked'){
			sauvegarder
		}
		Fenetre::boutonReinit_barre.signal_connect('clicked'){
			
		}
		Fenetre::boutonQuitter_barre.signal_connect('clicked'){
			Fenetre::detruire()
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
	## Met en place la partie de droite
	##
	## 
	##
	def gestionDroite()

		list = Gtk::ComboBoxText.new()
		list.signal_connect('changed'){ |widget|
			puts widget.active_text
		}

		list.append_text('Technique 1')
		list.append_text('Technique 2')
		list.append_text('Technique 3')
		list.append_text('Technique 4')
		list.append_text('Technique 5')
		@boxInfo.halign = :center
		@boxInfo.add(list)
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
