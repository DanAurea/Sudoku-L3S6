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
		@menuBarre=Fenetre::creerBarreMenu()
		@boxMilieu = Gtk::Box.new(:horizontal, 0)
		@boxGrille = Gtk::Box.new(:horizontal, 0)
		@boxInfo = Gtk::Box.new(:vertical, 0)
		@choixLabel = Fenetre::creerLabelType("<u>Choix de la technique</u>", Fenetre::SIZE_TITRE_JEU)
		@list = Gtk::ComboBoxText.new()
		@boxEtape = Gtk::Box.new(:horizontal, 0)
		@boutonEtapePrec = Gtk::Button.new(:label => "Precedente")
		@boutonEtapeSuiv = Gtk::Button.new(:label => "Suivante")
		@labelEtape = Fenetre::creerLabelType("Etape #{@etapeEnCours}/#{@nbEtape}", Fenetre::SIZE_TITRE_JEU)
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
		boxExplication = Gtk::Box.new(:horizontal, 0);
        boxExplication.set_hexpand(true);
        boxExplication.set_vexpand(true);

        boxTexte = Gtk::Box.new(:horizontal);
        boxTexteIn = Gtk::Box.new(:vertical);
        boxTexteIn.override_background_color(:normal, Gdk::RGBA.new(1,1,1,1));
        boxTexteIn.set_margin_top(10);
        boxTexteIn.set_margin_bottom(10);

        texteContenu = Gtk::Label.new("doizjediozejdiozejdijezdijeziodjzeiodjzeiodj dzeidze,iodze");
        texteContenu.set_margin(4)
        texteContenu.set_line_wrap(true);
        boxTexteIn.add(texteContenu);

        boxTexte.pack_start(boxTexteIn, :expand => true, :fill => true);
        boxExplication.pack_start(boxTexte, :expand => true, :fill => true);

		#add a la box
		@boxInfo.add(@choixLabel)
		@boxInfo.add(@list)
		@boxInfo.add(@boxEtape)
		@boxInfo.add(boxExplication)
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
