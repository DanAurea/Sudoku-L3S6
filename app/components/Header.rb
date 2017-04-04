require Core::ROOT + "model/Score.rb"

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
	## Définis le contenu de l'entête de la fenêtre
	##
	## @return     Module
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
	## Définis un accesseur pour le temps
	##
	## @return     Temps
	##
	def Header.temps()
		return @temps
	end

	##
	## Crée un chrono dans la header bar
	##
	## @return     self
	##
	def Header.chrono()
		@pause = false
		GLib::Timeout.add(1000) {
			if(@pause == false)
        		Header.addSecond
        	end
        }
        
        Fenetre::enteteFenetre.pack_end(@tempsLabel)
        Fenetre::enteteFenetre.pack_end(@scoreLabel)

        return self
	end
	
	##
	## Ajoute une seconde au chrono
	##
	## @return     True
	##
	def Header.addSecond()

		@reste += 0.5

		## Prend en compte un reste car Glib::Timeout 
		## a une granularité de 1 seconde
		if(@reste >= 1)
			@reste -=1
        	@temps += 1
		end

        @tempsLabel.text = "Temps: " + Header.surDeuxChiffres(@temps / 60) + ":" + Header.surDeuxChiffres(@temps % 60)
        @scoreLabel.text = "Score: " + @scoreModel.calcul(@penalite, @temps).to_s

        return true;
    end

    
    ##
    ## Convertis le temps sur deux chiffres
    ##
    ## @param      temps Le temps
    ##
    ## @return     Temps sur deux chiffres
    ##
    def Header.surDeuxChiffres(temps)
    	return temps.to_s.rjust(2, "0")
    end

end