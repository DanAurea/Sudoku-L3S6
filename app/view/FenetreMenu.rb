# 	squelette du menu
# 	
# 	Author:: 		PAVARD Valentin, DanAurea
# 	Developers: 	PAVARD Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 
class FenetreMenu < View

    #===Methode miseEnplace
    #
    # Permet de mettre en place la fenetre(taille, informations, conteneurs)
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
    	Fenetre::table.attach(Fenetre::creerLabelType("<u>Menu Principal</u>", 40, "#000000"),0,10,1,2)

        #Creation des Boutons
        boutonCharger=Gtk::Button.new("Reprendre une partie")
        
        boutonCharger.signal_connect('clicked'){
           Core::changeTo("Charger", "pseudo": @pseudo)
        }

        boutonNouveau=Gtk::Button.new("Nouvelle partie")
        boutonNouveau.signal_connect('clicked'){
            Core::changeTo("NouvellePartie", "pseudo": @pseudo)
        }

        boutonStat=Gtk::Button.new("Statistiques")
        boutonStat.signal_connect('clicked'){
            Core::changeTo("Statistiques", "pseudo": @pseudo)
        }

        boutonScore=Gtk::Button.new("Meilleurs scores")
        boutonScore.signal_connect('clicked'){
            Core::changeTo("Scores", "pseudo": @pseudo)
        }

        boutonReglage=Gtk::Button.new("Réglages")
        boutonReglage.signal_connect('clicked'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        boutonRegle=Gtk::Button.new("Règles de base")
        boutonRegle.signal_connect('clicked'){
            Core::changeTo("Regles", "pseudo": @pseudo)
        }

        boutonAPropos=Gtk::Button.new(Gtk::Stock::INFO)
        boutonAPropos.signal_connect('clicked'){
            aPropos()
        }

        boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
        boutonQuitter.signal_connect('clicked'){
        	Fenetre::detruire()
        }

        #attach des boutons
        Fenetre::table.attach(boutonCharger,3,7,3,4)
        Fenetre::table.attach(boutonNouveau,3,7,4,5)
        Fenetre::table.attach(boutonStat,3,7,5,6)
        Fenetre::table.attach(boutonScore,3,7,6,7)
        Fenetre::table.attach(boutonReglage,3,7,7,8)
        Fenetre::table.attach(boutonRegle,3,7,8,9)

        3.upto(8){|i| Fenetre::table.set_row_spacing(i, 5)}

        Fenetre::table.attach(boutonAPropos,1,3,10,11)
        Fenetre::table.attach(boutonQuitter,7,9,10,11)

    end

    def aPropos()
    	#popup explication du projet et des programmeurs
        tabNom=["JEAN Marvin => Chef de projet","COUSIN Brandon => Architecte","PAVARD Valentin => Interface GUI","DURAN Alizée => Documentaliste","GUENVER Yann => Développeur","TABOT Alexandre => Développeur","BUSSEREAU Keryann => Développeur","BODINEAU Bastien => Développeur"]

        fenetre = Gtk::AboutDialog.new()
        fenetre.set_program_name("Projet sudoku")
        fenetre.set_version("1.0")
        fenetre.set_copyright("(c) DogeTeam - Groupe B")
        fenetre.set_authors(tabNom.join("\n"))
        fenetre.set_comments("Dans le cadre du module 176EN001 intitulé Génie Logiciel 2 :\n Application à la conception à l'université du Maine, nous devons réaliser une interface à aides visuelles à la réalisation d’un Sudoku. Cela permet d’aider un utilisateur à résoudre un Sudoku sans réfléchir. La grille du Sudoku sera générée sur ordinateur.")
        
        fenetre.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)
        fenetre.set_title("Sudoku - A propos")
        fenetre.set_default_size(400,400)
        fenetre.border_width=0
        fenetre.set_resizable(false)
        
        fenetre.signal_connect('destroy') {
            fenetre.hide_all()
        }

        begin
            logo =GdkPixbuf::Pixbuf.new(:file => Core::ROOTPROJECT + "assets/img/logoS.jpeg", :width => 200, :height => 200)
            fenetre.set_logo(logo)
        rescue IOError => e
            puts e
            puts "Impossible de charger l'image du A Propos"
            exit
        end

        fenetre.run()
        fenetre.destroy()
    end

    ##
	## @brief     Lance la construction du modèle
	## 			  de la vue.
	## 			  Méthode à définir dans tout les cas !
	## 			  Autrement pas de rendu de la page.
	##
	## @return     itself
	##
	def run
		self.miseEnPlace()
		return self
	end
end
