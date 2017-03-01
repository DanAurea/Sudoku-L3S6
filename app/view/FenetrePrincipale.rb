#   Contient la classe representant une fenetre pour l'image de depart
#
#   Author::      PAVARD Valentin
#   Version::     0.1
#   Copyright::   ©
#   License::     Distributes under the same terms as Ruby


class FenetrePrincipale < View 

    @image
    @event_box

	def initialize()

        
	end

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
    	begin
    		@image = Gtk::Image.new(Core::ROOTPROJECT + "assets/img/sudokuIntro.jpg")
    	rescue IOError => e
    		puts e
    		puts "Impossible de charger l'image de depart"
    		exit
    	end

        #Creation des Boutons
        @event_box=Gtk::EventBox.new.add(@image)
        @event_box.signal_connect('button_press_event'){
        	Core::changeTo("Pseudo")
        }
        Fenetre::table.attach(@event_box,0,10,0,12)
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
		self.miseEnPlace
		controllerTest
		return self
	end

end
