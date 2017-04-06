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
		@boxTechnique = Gtk::Box.new(:vertical, 0)
		@boxGrille = Gtk::Box.new(:vertical, 0)
		@boxChiffres = Gtk::Box.new(:horizontal, 5)

		@boxChiffres.set_margin_top(10) 
		@boxChiffres.set_margin_left(10)

		@valeurSelectionnee = 1

		@grilleDessin = nil
	end


	##
	## Met à jour suite à la notification de la grille
	##
	## @param      x     Position x qui a subit une modification
	## @param      y     Position y qui a subit une modification
	##
	## @return     self
	##
	def update(x, y)
		updateGrille(x, y, @valeurSelectionnee)
		
		@grilleDessin.cases[x][y].nombre = @valeurSelectionnee
		
		self.resetIndices
		self.candidats
		@grilleDessin.redessiner

		return self
	end

	##
	## Crée le dessin de la grille
	##
	## @return     Self
	##
	def creerGrille()
		@grilleDessin = GrilleDessin.new(@grille, @config)
		@grilleDessin.add_observer(self)

		self.candidats
		@grilleDessin.indices = true

		## Dessine les boutons chiffres
		for i in 1..9
			boutonChiffre = Gtk::Button.new(:label => i.to_s, :expand => false, :fill => false)

			if(i == 1)
				@active = boutonChiffre
				@active.set_name("active")
			end

			boutonChiffre.signal_connect("clicked") do |widget|
				@valeurSelectionnee = widget.label.to_i
				@active.set_name("")
				@active = widget
				@active.set_name("active")
			end

			@boxChiffres.add(boutonChiffre)
		end


		img = Gtk::Image.new(:file => Core::ROOTPROJECT + "assets/img/eraser.png")
		boutonGomme = Gtk::Button.new(:label => "")

		boutonGomme.set_image(img)
		boutonGomme.set_always_show_image (true)

		boutonGomme.signal_connect("clicked") do
			@valeurSelectionnee = nil
			
			@active.set_name("")
			@active = boutonGomme
			@active.set_name("active")
		end

		@boxChiffres.add(boutonGomme)

		return self
	end

	##
	## Réinitialise les indices à false
	##
	## @return     self
	##
	def resetIndices()

		@grilleDessin.resetIndices()

		return self
	end

	##
	## Récupére les candidats et les définis pour l'affichage
	##
	## @return     self
	##
	def candidats
		listeCandidats = getCandidats

		## Affiche les candidats en parcourant ce qui a été calculé
		## pour chaque chiffre.
		listeCandidats.each do |key, candidats|

			candidats.each do |value| 
				x, y = value[0], value[1]
				@grilleDessin.cases[x][y].indices[key.to_s] = true
			end

		end
		
		return self
	end

	##
	## Met en place tout les éléments sur la page
	##
	##
	def miseEnPlace()
		#barre de menu
		gestionBarreMenu()

		ligne   = 0
		colonne = 0

		boutonIndices = Gtk::Button.new(:label => "Indices")
		boutonIndices.set_margin_top 10
		boutonIndices.set_margin_left 10

		boutonIndices.signal_connect("clicked"){
			if(@grilleDessin.indices? == true)
			 	@grilleDessin.indices = false
			else
			 	@grilleDessin.indices = true
			end

			@grilleDessin.redessiner
		}

		#box grille
		@boxGrille.add(@grilleDessin)
		@boxGrille.add(@boxChiffres)
		@boxGrille.add(boutonIndices)

		@boxMilieu.add(@boxGrille)
		@boxMilieu.add(@boxTechnique)

		#add a la box
		Fenetre::box.add(@menuBarre)
		Fenetre::box.add(@boxMilieu)
	end

	##
	## Réinitialise la grille
	##
	## @return     self
	##
	def reinitialiser
		for i in 0..8
			for j in 0..8
				if (@grilleDessin.cases[i][j].editable)
					@grilleDessin.cases[i][j].nombre = nil
					@grilleDessin.cases[i][j].indices = {"1" => false, "2" => false, "3" => false, "4" => false, "5" => false, "6" => false, "7" => false, "8" => false, "9" => false}
				end
			end
		end
		self.candidats
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
			# Réinitialise la grille (données)
			@controller.reinitialiser
			## Réinitialise la grille (affichage)
			self.reinitialiser
			@grilleDessin.redessiner
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