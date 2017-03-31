# => Contient la classe FenetrePseudo representant une fenetre pour le choix du pseudo
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetrePseudo
##
class FenetrePseudo < View 
	# VI
	@boxTop
    @boxBottom
    @entryPseudo

	##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
	def miseEnPlace()        
        creerBoxTop()
        creerBoxBottom()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

	##
    ## Créer la box verticale contenant la demande de pseudo et le titre
    ##
    ##
    def creerBoxTop()
		## Définis les classes des labels
		#titre
		titre = Fenetre::creerLabelType("<u>Choix du pseudo</u>")
		titre.style_context.add_class("titre_menu")
		#pseudo
		pseudo=Fenetre::creerLabelType(" Votre pseudo : ")
		pseudo.set_name("label_field_pseudo")
		
		#Creation des Boutons
		@entryPseudo=Gtk::Entry.new()
		@entryPseudo.set_max_length(15)
		@entryPseudo.style_context.add_class("field_pseudo")

		@entryPseudo.signal_connect("activate"){
			actionBoutonValider(@entryPseudo)
		}

		#add des boutons à la box
		@boxTop=Gtk::Box.new(:vertical,0)
		@boxTop.add(titre)
		@boxTop.add(pseudo)
		@boxTop.add(@entryPseudo)
    end

    ##
    #Creer la box horizontal contenant les boutons valider et quitter
    def creerBoxBottom()
        #Creation des Boutons
        boutonValider=Gtk::Button.new(:label => "Valider")
		boutonValider.style_context.add_class("bouton_bottom")
		boutonValider.signal_connect('button_press_event'){
		      actionBoutonValider(@entryPseudo)
		}

        boutonQuitter=Gtk::Button.new(:label => "Quitter")
        boutonQuitter.style_context.add_class("bouton_bottom")
        boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #add des boutons à la box
        @boxBottom=Gtk::Box.new(:horizontal, 0)
        @boxBottom.halign = :center
        @boxBottom.add(boutonQuitter)
        @boxBottom.add(boutonValider)
    end

	##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
	def run
		self.miseEnPlace
		Fenetre::css(:chemin => "/assets/css/FenetrePseudo.css")
		return self
	end
end
