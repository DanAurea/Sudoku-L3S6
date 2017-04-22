# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

require Core::ROOT + "components/GrilleDessin.rb"

##
## Classe FenetreApprentissage 
##
class FenetreApprentissage < View
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
		@grilleDessin = nil
		@scoreLabel   = nil

		#Recuperation de la classe technique
		@etapeEnCours=0
		@nbEtape=0
		@techniqueChoisie=""
		@texteContenu = Fenetre::creerLabelType("Bonjour, je suis là pour vous aider à apprendre des techniques!",Fenetre::SIZE_AUTRE_JEU)

		#liste technique
		@tabTechnique=[
						"SCandidate",
						"DSubset",
						"SCell"
					]
		#box
		@menuBarre = Fenetre::creerBarreMenu()
		@boxMilieu = Gtk::Box.new(:horizontal, 50)
		@boxGrille = Gtk::Box.new(:horizontal, 0)
		@boxInfo = Gtk::Box.new(:vertical, 40)
		@boxEtape = Gtk::Box.new(:horizontal, 30)
		@boxExplication = Gtk::Box.new(:horizontal, 0)
		@boxContour = Gtk::Box.new(:horizontal,0)
        @boxTexte = Gtk::Box.new(:vertical,10)
		
		#Choix technique
		@labelChoix = Fenetre::creerLabelType("<u>Choix de la technique</u>", Fenetre::SIZE_TITRE_JEU)
		@list = Gtk::ComboBoxText.new()

		#information de la technique
		@labelChoix2 = Fenetre::creerLabelType("Choississez une technique...", Fenetre::SIZE_AUTRE_JEU)
		@boutonEtapePrec = Gtk::Button.new(:label => "Precedente")
		@boutonEtapeSuiv = Gtk::Button.new(:label => " Suivante ")
		@labelEtape = Fenetre::creerLabelType("Etape #{@etapeEnCours}/#{@nbEtape}", Fenetre::SIZE_AUTRE_JEU)
	end

	##
	## Crée le dessin de la grille
	##
	## @return     Self
	##
	def creerGrille()
		@grilleDessin = GrilleDessin.new(@grille, @config)
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
			messageQuestion = Fenetre::creerPopup("Voulez-vous vraiment abandonner l'apprentissage et revenir au menu principal?", "YES_NO")
		    if(messageQuestion.run() == Gtk::ResponseType::YES)
		    	Core::changeTo("Menu", "pseudo": @pseudo)
		    end
		    messageQuestion.destroy()
		}
		Fenetre::boutonSauvegarder_barre.signal_connect('clicked'){
		}
		Fenetre::boutonReinit_barre.signal_connect('clicked'){
		}
		Fenetre::boutonQuitter_barre.signal_connect('clicked'){
			messageQuestion = Fenetre::creerPopup("Voulez-vous vraiment abandonner l'apprentissage et quitter l'application?", "YES_NO")
		    if(messageQuestion.run() == Gtk::ResponseType::YES)
		    	Fenetre::detruire()
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

		#disabled
		Fenetre::boutonSauvegarder_barre.set_sensitive(false)
		Fenetre::boutonReinit_barre.set_sensitive(false)
		Fenetre::boutonAnnuler_barre.set_sensitive(false)
		Fenetre::boutonRetablir_barre.set_sensitive(false)
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
