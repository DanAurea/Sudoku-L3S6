module Header

	@temps = 0
	@pause = false
	@reste = 0
	@tempsLabel = Gtk::Label.new("00:00")

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

	def Header.temps()
		return @temps
	end

	def Header.chrono()
		@pause = false
		GLib::Timeout.add(1000) {
			if(@pause == false)
        		Header.addSecond
        	end
        }
        
        Fenetre::enteteFenetre.pack_end(@tempsLabel)
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

        @tempsLabel.text = Header.toTwoDigits(@temps / 60) + ":" + Header.toTwoDigits(@temps % 60)

        return true;
    end

    def Header.toTwoDigits(temps)
    	return temps.to_s.rjust(2, "0")
    end

end