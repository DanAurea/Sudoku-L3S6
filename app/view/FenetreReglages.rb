# 	Fichier contenant la gestion des reglages(taille, couleur)
# 	
# 	Author:: 		PAVARD Valentin, DanAurea
# 	Developers: 	PAVARD Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreReglages < View

	def initialize()
		
	end

	#===Methode miseEnplace
    #
    # Permet de mettre en place la fenetre(conteneurs)
    #
    # * *Args*    :
    #   - /
    # * *Returns* :
    #   - /
    #
	def miseEnPlace()
		#titre et pseudo
        event_box=Gtk::EventBox.new.add(Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}", 15, "#FF0000"))
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }
    	Fenetre::table.attach(event_box,7,10,0,1)
    	Fenetre::table.attach(Fenetre::creerLabelType("<u>Réglages</u>", 40, "#000000"),0,10,1,2)

        #Creation des Boutons
        frame1 = Gtk::Frame.new(" Choix taille des chiffres ")
        frame1.shadow_type = Gtk::ShadowType::ETCHED_OUT

        tableTaille=Gtk::Table.new(4,1,false)
        boutonPetitChiffre = Gtk::RadioButton.new(:label => "Petit Chiffre")
        boutonGrandChiffre = Gtk::RadioButton.new(:member => boutonPetitChiffre, :label => "Grand Chiffre")
        #tableTaille.attach(Gtk::Image.new(CHEMIN_IMAGE_PETIT_CHIFFRE_REGLAGE),0,1,0,1)
        tableTaille.attach(boutonPetitChiffre,1,2,0,1)
        #tableTaille.attach(Gtk::Image.new(CHEMIN_IMAGE_GRAND_CHIFFRE_REGLAGE),2,3,0,1)
        tableTaille.attach(boutonGrandChiffre,3,4,0,1)
        frame1.add(tableTaille)

        frame2 = Gtk::Frame.new(" Choix de la couleur ")
        frame2.shadow_type = Gtk::ShadowType::ETCHED_OUT
        tableCouleur=Gtk::Table.new(8,2,false)
        
        boutonBlanc = Gtk::RadioButton.new(:label => "Blanc")
        boutonBleu = Gtk::RadioButton.new(:member => boutonBlanc,:label => "Bleu")
        boutonJaune = Gtk::RadioButton.new(:member => boutonBlanc,:label => "Jaune")
        boutonOrange = Gtk::RadioButton.new(:member => boutonBlanc,:label => "Orange")
        boutonRouge = Gtk::RadioButton.new(:member => boutonBlanc,:label => "Rouge")
        boutonTurquoise = Gtk::RadioButton.new(:member => boutonBlanc,:label => "Turquoise")
        boutonVert = Gtk::RadioButton.new(:member => boutonBlanc,:label => "Vert")
        boutonViolet = Gtk::RadioButton.new(:member => boutonBlanc,:label => "Violet")

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_BLANC_REGLAGE),0,1,0,1)
        tableCouleur.attach(boutonBlanc,1,2,0,1)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_BLEU_REGLAGE),2,3,0,1)
        tableCouleur.attach(boutonBleu,3,4,0,1)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_JAUNE_REGLAGE),4,5,0,1)
        tableCouleur.attach(boutonJaune,5,6,0,1)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_ORANGE_REGLAGE),6,7,0,1)
        tableCouleur.attach(boutonOrange,7,8,0,1)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_ROUGE_REGLAGE),0,1,1,2)
        tableCouleur.attach(boutonRouge,1,2,1,2)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_TURQUOISE_REGLAGE),2,3,1,2)
        tableCouleur.attach(boutonTurquoise,3,4,1,2)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_VERT_REGLAGE),4,5,1,2)
        tableCouleur.attach(boutonVert,5,6,1,2)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_VIOLET_REGLAGE),6,7,1,2)
        tableCouleur.attach(boutonViolet,7,8,1,2)

        tableCouleur.set_row_spacing(0, 10)
        tableCouleur.set_row_spacing(1, 10)
        frame2.add(tableCouleur)

        boutonRetour=Gtk::Button.new(:label => "Retour")
        boutonRetour.signal_connect('clicked'){
            Core::back()
        }

        boutonQuitter=Gtk::Button.new(:label => "Quitter")
        boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #attach des boutons
        Fenetre::table.attach(frame1,2,8,2,4)
        Fenetre::table.attach(frame2,1,9,5,9)
        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
    end

    ##
	## @brief     Lance la construction du modèle
	## 			  de la vue.
	## 			  Méthode à définir dans tout les cas !
	## 			  Autrement pas de rendu de la page.
	##
	## @return     itself
	##
	def run()
		self.miseEnPlace()
		return self
	end

end
