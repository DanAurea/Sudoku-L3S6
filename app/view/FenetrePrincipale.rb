class FenetrePrincipale < View 

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