# 	Fichier contenant les règles de base dans le jeu
# 	
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
class FenetreRegles < View

	@boxTop
    @boxBottom

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
        creerBoxTop()
        creerBoxBottom()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

	##
    #Creer la box vertical contenant les boutons des niveaux et le titre
    def creerBoxTop()
		## Définis les classes des labels
		#titre
		titre = Fenetre::creerLabelType("<u>Règles</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo = Fenetre::creerLabelType("<u>Pseudo:</u> #{@pseudo.capitalize}")
		pseudo.style_context.add_class("pseudo_menu")
        pseudo.halign = :end
        #regles enoncées
        regle0= Fenetre::creerLabelType("******************************************************************")
        regle0.halign = :start
        regle0.style_context.add_class("label_regles_t")
        regle1 = Fenetre::creerLabelType("- Un sudoku classique contient 9 lignes et 9 colonnes,")
        regle1.halign = :start
        regle1.style_context.add_class("label_regles_s")
        regle2 = Fenetre::creerLabelType("soit 81 cases au total.")
        regle2.halign = :start
        regle2.style_context.add_class("label_regles")
        regle3 = Fenetre::creerLabelType("- Le but du jeu est de remplir ces cases avec des chiffres")
        regle3.halign = :start
        regle3.style_context.add_class("label_regles_s")
        regle4 = Fenetre::creerLabelType("allant de 1 à 9 en veillant toujours à ce qu'un même chiffre")
        regle4.halign = :start
        regle4.style_context.add_class("label_regles")
        regle5 = Fenetre::creerLabelType("ne figure qu'une seule fois par colonne, une seule fois par")
        regle5.halign = :start
        regle5.style_context.add_class("label_regles")
        regle6 = Fenetre::creerLabelType("ligne et une seule fois par carré de 9 cases(appelé région).")
        regle6.halign = :start
        regle6.style_context.add_class("label_regles")
        regle7 = Fenetre::creerLabelType("- Au début du jeu, une vingtaine de chiffres sont déjà placés")
        regle7.halign = :start
        regle7.style_context.add_class("label_regles_s")
        regle8 = Fenetre::creerLabelType("et il vous reste à  trouver les autres. En effet, une grille")
        regle8.halign = :start
        regle8.style_context.add_class("label_regles")
        regle9 = Fenetre::creerLabelType("initiale de sudoku correctement constituée ne peut aboutir qu'à")
        regle9.halign = :start
        regle9.style_context.add_class("label_regles")
        regle10 = Fenetre::creerLabelType("une et une seule solution. Pour trouver les chiffres manquants,")
        regle10.halign = :start
        regle10.style_context.add_class("label_regles")
        regle11 = Fenetre::creerLabelType("tout est une question de logique et d'observation.")
        regle11.halign = :start
        regle11.style_context.add_class("label_regles")
        regle12 = Fenetre::creerLabelType("- Suivez le tutoriel pour vous faciliter la tache et")
        regle12.halign = :start
        regle12.style_context.add_class("label_regles_s")
        regle13 = Fenetre::creerLabelType("apprendre certaines techniques...")
        regle13.halign = :start
        regle13.style_context.add_class("label_regles")
        regle14 = Fenetre::creerLabelType("******************************************************************")
        regle14.style_context.add_class("label_regles_t")
        regle14.halign = :start

		#Creation des Boutons
        event_box=Gtk::EventBox.new.add(pseudo)
        event_box.signal_connect('button_press_event'){
            Core::changeTo("Reglages", "pseudo": @pseudo)
        }

        #regles enoncées
        table=Gtk::Table.new(1,15,false)
        table.attach(regle0,0,1,0,1)
        table.attach(regle1,0,1,1,2)
        table.attach(regle2,0,1,2,3)
        table.attach(regle3,0,1,3,4)
        table.attach(regle4,0,1,4,5)
        table.attach(regle5,0,1,5,6)
        table.attach(regle6,0,1,6,7)
        table.attach(regle7,0,1,7,8)
        table.attach(regle8,0,1,8,9)
        table.attach(regle9,0,1,9,10)
        table.attach(regle10,0,1,10,11)
        table.attach(regle11,0,1,11,12)
        table.attach(regle12,0,1,12,13)
        table.attach(regle13,0,1,13,14)
        table.attach(regle14,0,1,14,15)

        #add des boutons
        @boxTop=Gtk::Box.new(:vertical,0)
        @boxTop.add(event_box)
        @boxTop.add(titre)
        @boxTop.add(table)
    end

    ##
    #Creer la box horizontal contenant les boutons retour et quitter
    def creerBoxBottom()
        #Creation des Boutons
        boutonRetour=Gtk::Button.new(:label => "Retour")
        boutonRetour.style_context.add_class("bouton_bottom")
        boutonRetour.signal_connect('clicked'){
            Core::back()
        }

        boutonQuitter=Gtk::Button.new(:label => "Quitter")
        boutonQuitter.style_context.add_class("bouton_bottom")
        boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #add des boutons
        @boxBottom=Gtk::Box.new(:horizontal, 0)
        @boxBottom.halign = :center
        @boxBottom.add(boutonRetour)
        @boxBottom.add(boutonQuitter)
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
		Fenetre::css(:chemin => "/assets/css/FenetreRegles.css")
		return self
	end

end
