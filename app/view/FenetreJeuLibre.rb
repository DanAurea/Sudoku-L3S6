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
	## VI box
	@menuBarre
	@boxMilieu
	@boxGrille
	@boxInfo
	@boxTexte
	@boxExplication
	@boxEtape

	# VI dessin
	@grilleDessin
	@scoreLabel

	# VI info
	@labelChoix 
	@list
	@labelChoix2
	@boutonEtapePrec
	@boutonEtapeSuiv
	@labelEtape
	
	
	# VI recup
	@etapeEnCours
	@nbEtape
	@techniqueChoisie
	@texteContenu
	@tabTechnique
	@techniqueObjet

	##
	## Initialize
	##
	##
	def initialize()
		#liste technique
		@tabTechnique=[
						"SCandidate",
						"DSubset",
						"SCell"
					]

		#Recuperation de la classe technique
		@etapeEnCours=0
		@nbEtape=0
		@techniqueChoisie=""
		@texteContenu = Fenetre::creerLabelType("Bonjour, si vous choisissez une technique, une pénalité sera décompté du score !",Fenetre::SIZE_AUTRE_JEU)

		#box
		@menuBarre=Fenetre::creerBarreMenu()
		@boxMilieu = Gtk::Box.new(:horizontal, 0)
		@boxGrille = Gtk::Box.new(:vertical, 0)
		@boxChiffres = Gtk::Box.new(:horizontal, 5)
		@boxChiffres.set_margin_top(10) 
		@boxChiffres.set_margin_left(3)
		@boxInfo = Gtk::Box.new(:vertical, 40)
		@boxEtape = Gtk::Box.new(:horizontal, 30)
		@boxExplication = Gtk::Box.new(:horizontal, 0)
		@boxContour = Gtk::Box.new(:horizontal,0)
        @boxTexte = Gtk::Box.new(:vertical,10)
        @boxInvisible = Gtk::Label.new("")
        @boxInvisible.set_size_request(50, 150)

		#Choix technique
		@labelChoix = Fenetre::creerLabelType("<u>Choisir une aide</u>", Fenetre::SIZE_TITRE_JEU)
		@list = Gtk::ComboBoxText.new()

		#information de la technique
		@labelChoix2 = Fenetre::creerLabelType("Choississez une technique...", Fenetre::SIZE_AUTRE_JEU)
		@boutonEtapePrec = Gtk::Button.new(:label => "Precedente")
		@boutonEtapeSuiv = Gtk::Button.new(:label => " Suivante ")
		@labelEtape = Fenetre::creerLabelType("Etape #{@etapeEnCours}/#{@nbEtape}", Fenetre::SIZE_AUTRE_JEU)

		@valeurSelectionnee = nil
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
		@grilleDessin.reset()
		updateGrille(x, y, @valeurSelectionnee)

		@grilleDessin.cases[x][y].nombre = @valeurSelectionnee
		
		self.resetIndices
		self.candidats
		@grilleDessin.redessiner

		if(finPartie?())
			partieTerminee()

			mess = Fenetre::creerPopup("Bravo partie terminée !", "CLOSE")
			
			if(mess.run() == Gtk::ResponseType::CLOSE)
				Header.profil(@pseudo)
				Core::changeTo("Menu", :pseudo => @pseudo)
			end

			mess.destroy()
		elsif(getNbVides == 0)
			
			Header.penalite()

			mess = Fenetre::creerPopup("Erreur sur la grille !", "CLOSE")
			mess.run()
			mess.destroy()
		end

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

			boutonChiffre.signal_connect("clicked") do |widget|
				@valeurSelectionnee = widget.label.to_i
				
				@grilleDessin.reset

				@grilleDessin.memeValeurs(@valeurSelectionnee)
				@grilleDessin.redessiner
				
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
			@grilleDessin.reset
			@grilleDessin.redessiner
			@valeurSelectionnee = nil
			
			@active.set_name("")
			@active = boutonGomme
			@active.set_name("active")

		end

		@active = boutonGomme
		@active.set_name("active")

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

		boutonIndices = Gtk::Button.new(:label => "Désactiver indices")
		boutonIndices.override_color(:normal, Fenetre::COULEUR_BLANC)

		boutonIndices.signal_connect("clicked"){
			if(@grilleDessin.indices? == true)
			 	@grilleDessin.indices = false
			 	boutonIndices.label = "Activer indices"
			else
			 	@grilleDessin.indices = true
			 	boutonIndices.label = "Désactiver indices"
			end
			boutonIndices.override_color(:normal, Fenetre::COULEUR_BLANC)

			@grilleDessin.redessiner
		}

		#partie droite
		gestionDroite()

		#box grille
		@boxGrille.add(@grilleDessin)
		@boxGrille.add(boutonIndices)
		@boxGrille.add(@boxChiffres)

		@boxMilieu.add(@boxGrille)
		@boxMilieu.add(@boxInfo)
		@boxInfo.add(@boxInvisible)

		ajoutCss()

		#add a la box
		Fenetre::box.add(@menuBarre)
		Fenetre::box.add(@boxMilieu)
	end

	##
	## actualisation informations
	##
	def actualisation()
		@labelChoix2.set_text("Explication de #{@techniqueChoisie}")
		@labelEtape.set_text("Etape #{@etapeEnCours}/#{@nbEtape}")
		recuperationEtape()
	end

	##
	## Recuperatuon du nombre d'etapes pour le tutoriel
	##
	##
	def recuperationNbEtape()
		@nbEtape=@techniqueObjet.combienEtape()
	end

	##
	## Recuperatuon du texte de l'etape en cours
	##
	##
	def recuperationEtape()
		string=@techniqueObjet.etape(@etapeEnCours)
		@texteContenu.set_text(string)
	end

	##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @labelChoix.override_color(:normal, Fenetre::COULEUR_BLANC)
        @labelChoix.set_margin_top(40)
        @list.set_hexpand(true);
        @labelEtape.override_color(:normal, Fenetre::COULEUR_BLANC)
        @labelEtape.set_hexpand(true);
        @texteContenu.override_color(:normal, Fenetre::COULEUR_BLANC)
        @texteContenu.set_margin(4)
        @labelChoix2.override_color(:normal, Fenetre::COULEUR_BLANC)
        #css bouton
        @boxContour.override_background_color(:normal, Fenetre::COULEUR_BLANC)
        @boxTexte.override_background_color(:normal, Fenetre::COULEUR_BLEU)
        @boxTexte.set_margin(3)
        @boutonEtapePrec.set_hexpand(true);
        @boutonEtapeSuiv.set_hexpand(true);
        @boxInfo.set_margin(10)
    end

    ##
	## Met en place la partie de droite
	##
	## 
	##
	def gestionDroite()
		#choix technique
		@tabTechnique.each{ |t|
			@list.append_text("#{t}")
		}

		@list.signal_connect('changed'){ |widget|
			Header.penalite()
			@techniqueChoisie=widget.active_text()
			@techniqueObjet=@Techniques.creer(@techniqueChoisie)
			@nbEtape= recuperationNbEtape()
			@etapeEnCours=1
			actualisation()
		}

		#etapes
		@boutonEtapePrec.signal_connect('clicked'){
			if @etapeEnCours-1 > 0
				@etapeEnCours=@etapeEnCours-1
				actualisation()
			end
		}

		@boutonEtapeSuiv.signal_connect('clicked'){
			if @etapeEnCours+1 <= @nbEtape
				@etapeEnCours=@etapeEnCours+1
				actualisation()
			end
		}

		@boxEtape.add(@boutonEtapePrec)
		@boxEtape.add(@labelEtape)
		@boxEtape.add(@boutonEtapeSuiv)

		#explication
        @boxExplication.set_hexpand(true)
        @boxExplication.set_vexpand(true)

        @texteContenu.set_line_wrap(true)
        @boxTexte.add(@texteContenu)
        @boxContour.pack_start(@boxTexte, :expand => true, :fill => true)
        @boxExplication.pack_start(@boxContour, :expand => true, :fill => true)

		#add a la box
		@boxInfo.add(@labelChoix)
		@boxInfo.add(@list)
		@boxInfo.add(@labelChoix2)
		@boxInfo.add(@boxEtape)
		@boxInfo.add(@boxExplication)
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
			messageQuestion = Fenetre::creerPopup("1/2: Voulez-vous vraiment abandonner la partie et revenir au menu principal ?", "YES_NO")
		    if(messageQuestion.run() == Gtk::ResponseType::YES)
		    	messageQuestion2 = Fenetre::creerPopup("2/2: Voulez-vous sauvegarder la partie actuelle?", "YES_NO")
		    	if(messageQuestion2.run() == Gtk::ResponseType::YES)
		    		sauvegarder()
		    	end

		    	Header.profil(@pseudo)
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
			if(Header::pause == true)
				Header::pause = false
				Header::chrono
			end
		}
		
		Fenetre::boutonAnnuler_barre.signal_connect('clicked'){
		}
		Fenetre::boutonRetablir_barre.signal_connect('clicked'){
		}
		#disabled
		Fenetre::boutonAnnuler_barre.set_sensitive(false)
		Fenetre::boutonRetablir_barre.set_sensitive(false)
	end

	##
	## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
	##
	## @return self
	##
	def run()
		self.creerGrille()
		self.miseEnPlace()
		
		Header::chrono

		return self
	end
end
