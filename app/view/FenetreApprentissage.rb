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
	@boxBouton
	@grilleDessin
	@scoreLabel
	@techniqueObjet

	##
	## Initialize
	##
	##
	def initialize()
		Header::chrono
		@grilleDessin = nil
		@scoreLabel   = nil

		#Recuperation de la classe technique
		@etapeEnCours=0
		@nbEtape=0
		@techniqueChoisie=""
		@texteContenu = Gtk::Label.new("")

		#liste technique
		@tabTechnique=[
						"Fonctionnement du jeu",
						"SCandidate",
					]
		#box
		@menuBarre = Fenetre::creerBarreMenu()
		@boxMilieu = Gtk::Box.new(:horizontal, 50)
		@boxGrille = Gtk::Box.new(:horizontal, 0)
		@boxInfo = Gtk::Box.new(:vertical, 40)
		@boxTexte = Gtk::Box.new(:vertical,10)
		
		#Choix technique
		@labelChoix = Fenetre::creerLabelType("<u>Choix de la technique</u>", Fenetre::SIZE_TITRE_JEU)
		@list = Gtk::ComboBoxText.new()

		#information de la technique
		@labelChoix2 = Fenetre::creerLabelType("Choississez une technique...", Fenetre::SIZE_AUTRE_JEU)
		@boxEtape = Gtk::Box.new(:horizontal, 30)
		@boutonEtapePrec = Gtk::Button.new(:label => "Precedente")
		@boutonEtapeSuiv = Gtk::Button.new(:label => " Suivante ")
		@labelEtape = Fenetre::creerLabelType("Etape #{@etapeEnCours}/#{@nbEtape}", Fenetre::SIZE_AUTRE_JEU)
		@boxExplication = Gtk::Box.new(:horizontal, 0)
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

		ajoutCss()

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
		#choix technique
		@tabTechnique.each{ |t|
			@list.append_text("#{t}")
		}

		@list.signal_connect('changed'){ |widget|
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
        @texteContenu.set_line_wrap(true)
        @boxTexte.add(@texteContenu)
        @boxExplication.add(@boxTexte)

		#add a la box
		@boxInfo.add(@labelChoix)
		@boxInfo.add(@list)
		@boxInfo.add(@labelChoix2)
		@boxInfo.add(@boxEtape)
		@boxInfo.add(@boxExplication)
	end

	##
	## actualisation informations
	##
	def actualisation()
		@labelChoix2.set_text("Explication de #{@techniqueChoisie}")
		@labelEtape.set_text("Etape #{@etapeEnCours}/#{@nbEtape}")
		recuperationEtape()
	end

	##TODO
	def recuperationNbEtape()
		if @techniqueChoisie == "Fonctionnement du jeu"
			@nbEtape=0
		else
			@nbEtape=@techniqueObjet.combienEtape()
		end
	end

	def recuperationEtape()
		if @techniqueChoisie == "Fonctionnement du jeu"
			@texteContenu.set_text("doizjediozejdiozejdijezdijeziodjzeiodjzeiodj dzeidze,iodze")
		else
			string=@techniqueObjet.etape(@etapeEnCours)
			@texteContenu.set_text(string)
		end
	end

	##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @labelChoix.override_color(:normal, Fenetre::COULEUR_BLANC)
        @labelChoix.set_margin_top(40)
        @labelEtape.override_color(:normal, Fenetre::COULEUR_BLANC)
        @texteContenu.override_color(:normal, Fenetre::COULEUR_BLANC)
        @labelChoix2.override_color(:normal, Fenetre::COULEUR_BLANC)
        #css bouton
        @boxTexte.override_background_color(:normal, Fenetre::COULEUR_ORANGE)
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
