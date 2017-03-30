#   Contient la classe representant une fenetre pour l'image de depart
#
#   Author::        Valentin, DanAurea
#   Developers:     Valentin, DanAurea
#   Version::     0.1
#   Copyright::   ©
#   License::     Distributes under the same terms as Ruby

class FenetrePrincipale < View 
    
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
    		image = Gtk::Image.new(:file => Core::ROOTPROJECT + "assets/img/sudokuIntro.jpg")
    	rescue IOError => e
    		puts e
    		puts "Impossible de charger l'image de depart"
    		exit
    	end

        #Creation des Boutons
        event_box=Gtk::EventBox.new.add(image)
        event_box.signal_connect('button_press_event'){
        	Core::changeTo("Pseudo")
        }
        Fenetre::box.add(event_box)
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
		return self
	end

end
