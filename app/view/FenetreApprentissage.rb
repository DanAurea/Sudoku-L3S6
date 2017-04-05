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

	##
	## Initialize
	##
	##
	def initialize()
		Header::chrono
		@etapeEnCours=2
		@nbEtape=6

		@menuBarre = Fenetre::creerBarreMenu()
		@boxMilieu = Gtk::Box.new(:horizontal, 0)
		@boxGrille = Gtk::Box.new(:horizontal, 0)
		@boxInfo = Gtk::Box.new(:vertical, 0)
		
		@labelChoix = Fenetre::creerLabelType("<u>Choix de la technique</u>", Fenetre::SIZE_TITRE_JEU)
		@list = Gtk::ComboBoxText.new()
		
		@boxEtape = Gtk::Box.new(:horizontal, 0)
		@boutonEtapePrec = Gtk::Button.new(:label => "Precedente")
		@boutonEtapeSuiv = Gtk::Button.new(:label => "Suivante")
		@labelEtape = Fenetre::creerLabelType("Etape #{@etapeEnCours}/#{@nbEtape}", Fenetre::SIZE_TITRE_JEU)
		
		@boxExplication = Gtk::Box.new(:horizontal, 0)
		@texteContenu = Gtk::Label.new("doizjediozejdiozejdijezdijeziodjzeiodjzeiodj dzeidze,iodze")

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
		@list.signal_connect('changed'){ |widget|
			puts widget.active_text
		}
		@list.append_text('Technique 1')
		@list.append_text('Technique 2')
		@list.append_text('Technique 3')
		@list.append_text('Technique 4')
		@list.append_text('Technique 5')

		#etapes
		@boutonEtapePrec.signal_connect('clicked'){

		}

		@boutonEtapeSuiv.signal_connect('clicked'){

		}
		@boxEtape.add(@boutonEtapePrec)
		@boxEtape.add(@labelEtape)
		@boxEtape.add(@boutonEtapeSuiv)

		#explication
        boxTexte = Gtk::Box.new(:vertical)
        @texteContenu.set_line_wrap(true)
        boxTexte.add(@texteContenu)
        @boxExplication.add(boxTexte)

		#add a la box
		@boxInfo.add(@labelChoix)
		@boxInfo.add(@list)
		@boxInfo.add(@boxEtape)
		@boxInfo.add(@boxExplication)
	end

	##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @labelChoix.set_margin(20)
        @labelChoix.override_color(:normal, Fenetre::COULEUR_BLANC)
        @labelEtape.set_margin(20)
        @labelEtape.override_color(:normal, Fenetre::COULEUR_BLANC)
        @texteContenu.set_margin(20)
        @texteContenu.override_color(:normal, Fenetre::COULEUR_BLANC)
        #css bouton
        @list.set_margin(20)
        @boutonEtapePrec.set_margin(20)
        @boutonEtapeSuiv.set_margin(20)
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
