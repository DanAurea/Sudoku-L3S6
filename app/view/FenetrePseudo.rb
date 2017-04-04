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
    ## Initialize
    ##
    def initialize()
    	# VI box
    	@boxTop = Gtk::Box.new(:vertical,0)
    	@boxBottom = Gtk::Box.new(:horizontal, 0)
    	# VI bouton
    	@entryPseudo = Gtk::Entry.new()
    	@boutonValider = Gtk::Button.new(:label => "Valider")
    	@boutonQuitter = Gtk::Button.new(:label => "Quitter")
    	# VI label
    	@titreLabel = Fenetre::creerLabelType("<u>Choix du pseudo</u>",Fenetre::SIZE_TITRE)
    	@pseudoLabel = Fenetre::creerLabelType("Votre pseudo : ",Fenetre::SIZE_PSEUDO)
    end

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
		#Action des boutons
		@entryPseudo.set_max_length(15)
		@entryPseudo.signal_connect("activate"){
			actionBoutonValider(@entryPseudo)
		}

		#add des boutons à la box
		@boxTop.add(@titreLabel)
		@boxTop.add(@pseudoLabel)
		@boxTop.add(@entryPseudo)
    end

    ##
    #Creer la box horizontal contenant les boutons valider et quitter
    def creerBoxBottom()
       #Action des boutons
		@boutonValider.signal_connect('button_press_event'){
		      actionBoutonValider(@entryPseudo)
		}

        @boutonQuitter.signal_connect('clicked'){
            Fenetre::detruire()
        }

        #add des boutons à la box
        @boxBottom.halign = :center
        @boxBottom.valign = :center
        @boxBottom.add(@boutonQuitter)
        @boxBottom.add(@boutonValider)
    end

    ##
    ## Ajoute les classes css au widget
    ##
    def ajoutCss()
        #css label
        @titreLabel.override_color(:normal, Fenetre::COULEUR_BLANC)
        @titreLabel.set_margin_top(30)
        @pseudoLabel.override_color(:normal, Fenetre::COULEUR_BLANC)
        @pseudoLabel.set_margin_top(80)
        @pseudoLabel.set_margin_bottom(30)
        #css bouton
        @entryPseudo.set_margin_left(100)
        @entryPseudo.set_margin_right(100)
        @boutonValider.set_margin(40)
        @boutonValider.set_margin_top(60)
        @boutonQuitter.set_margin(40)
        @boutonQuitter.set_margin_top(60)
    end

	##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
	def run
		self.miseEnPlace()
		return self
	end
end
