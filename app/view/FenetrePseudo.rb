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
    # VI box
    @boxTop
    @boxBottom
    # VI bouton
    @entryPseudo
    @boutonValider
    @boutonQuitter
    # VI label
    @titreLabel
    @pseudoLabel

	##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
	def miseEnPlace()        
        creerBoxTop()
        creerBoxBottom()
        ajoutCss()
        Fenetre::box.add(@boxTop)
        Fenetre::box.add(@boxBottom)
    end

	##
    ## Créer la box verticale contenant la demande de pseudo et le titre
    ##
    ##
    def creerBoxTop()
		#labels
		@titreLabel = Fenetre::creerLabelType("<u>Choix du pseudo</u>")
		@pseudoLabel=Fenetre::creerLabelType(" Votre pseudo : ")
		
		#Creation des Boutons
		@entryPseudo=Gtk::Entry.new()
		@entryPseudo.set_max_length(15)

		@entryPseudo.signal_connect("activate"){
			@controller.actionBoutonValider(@entryPseudo)
		}

		#add des boutons à la box
		@boxTop=Gtk::Box.new(:vertical,0)
		@boxTop.add(@titreLabel)
		@boxTop.add(@pseudoLabel)
		@boxTop.add(@entryPseudo)
    end

    ##
    #Creer la box horizontal contenant les boutons valider et quitter
    def creerBoxBottom()
        #Creation des Boutons
        @boutonValider=Gtk::Button.new(:label => "Valider")
		@boutonValider.signal_connect('button_press_event'){
		      @controller.actionBoutonValider(@entryPseudo)
		}

        @boutonQuitter=Gtk::Button.new(:label => "Quitter")
        @boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #add des boutons à la box
        @boxBottom=Gtk::Box.new(:horizontal, 0)
        @boxBottom.halign = :center
        @boxBottom.add(@boutonQuitter)
        @boxBottom.add(@boutonValider)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.style_context.add_class("titre_menu")
        @pseudoLabel.set_name("label_field_pseudo")
        #css bouton
        @entryPseudo.style_context.add_class("field_pseudo")
        @boutonValider.style_context.add_class("bouton_bottom")
        @boutonQuitter.style_context.add_class("bouton_bottom")
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
