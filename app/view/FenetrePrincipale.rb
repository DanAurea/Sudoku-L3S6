# => Contient la classe FenetrePrincipale qui affiche l'image d'intro
#
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## classe FenetrePrincipale
##
class FenetrePrincipale < View 
    
    ##
    ## Permet de créer et d'ajouter les box au conteneur principal
    ##
    ##
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

        #add des boutons à la box
        Fenetre::box.add(event_box)
	end

	##
    ## Lance la construction du modèle de la vue. Méthode à définir dans tout les cas ! Autrement pas de rendu de la page.
    ##
    ## @return self
    ##
	def run
		self.miseEnPlace
		return self
	end
end
