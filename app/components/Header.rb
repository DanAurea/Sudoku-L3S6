# => Author:: 		Valentin, DanAurea
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby

require Core::ROOT + "model/Score.rb"

##
## Module permettant de 
##

module Header

	@scoreModel = Score.instance()

	@temps = 0
	@pause = false
	@reste = 0
	
	@tempsLabel = Gtk::Label.new("Temps: 00:00")
	@scoreLabel = Gtk::Label.new("Score: 0")
	
	@score    = 0
	@penalite = 0

	##
	## Définit le contenu de l'entête de la fenêtre
	##
	## @return 	Module
	##
	def Header.profil(pseudo)

		## Création du bouton de profil
		boutonProfil = Gtk::Button.new
		image = Gtk::Image.new(:file => Core::ROOTPROJECT + "assets/img/user.png")
		
		box = Gtk::Box.new(:horizontal, 5)

		boutonProfil.signal_connect("clicked")  do
			@pause = true
			Core::changeTo("Reglages", :pseudo => pseudo)
		end

		boutonProfil.set_name("profil")
		boutonProfil.add(image)
		box.add(boutonProfil)

		pseudoProfil = Gtk::Label.new(pseudo.capitalize).set_name("pseudo")
		box.add(pseudoProfil)


		## Ajout au début de l'entête
		Fenetre::enteteFenetre.pack_start(box)

		return self
	end

	##
	## Définit l'état de la pause
	##
	## @param 	bool			Booléen de l'état
	##
	## @return 	L'état de la pause
	##
	def Header.pause=(bool) 
		@pause = bool
	end

	##
	## Définit un accesseur pour le temps
	##
	## @return 	temps
	##
	def Header.temps()
		return @temps
	end

	##
	## Définit un accesseur pour le score
	##
	## @return 	score
	##
	def Header.score()
		return @score
	end

	##
	## Crée un chrono dans la header bar
	##
	## @return 	self
	##
	def Header.chrono()
        
        Fenetre::enteteFenetre.pack_end(@tempsLabel)
        Fenetre::enteteFenetre.pack_end(@scoreLabel)
		
		GLib::Timeout.add(1000) {
        	Header.addSecond
        }

        return self
	end
	
	##
	## Ajoute une seconde au chrono
	##
	## @return 	true
	##
	def Header.addSecond()

		if(@pause == false)
			@reste += 0.5

			## Prend en compte un reste car Glib::Timeout 
			## a une granularité de 1 seconde
			if(@reste >= 1)
				@reste -=1
	        	@temps += 1
			end

	        @tempsLabel.text = "Temps: " + Header.surDeuxChiffres(@temps / 60) + ":" + Header.surDeuxChiffres(@temps % 60)
	        @score = @scoreModel.calcul(@penalite, @temps)
	        @scoreLabel.text = "Score: " + @score.to_s
	    end

        return true;
    end

    
    ##
    ## Convertit le temps sur deux chiffres
    ##
    ## @param 	temps 			Le temps
    ##
    ## @return 	Temps sur deux chiffres
    ##
    def Header.surDeuxChiffres(temps)
    	return temps.to_s.rjust(2, "0")
    end

end