require Core::ROOT + "model/Score.rb"

module Header

	@scoreModel = Score.instance()

	@temps = 0
	@pause = false
	
	@tempsLabel = Gtk::Label.new("Temps: 00:00")
	@scoreLabel = Gtk::Label.new("Score: 0")
	
	@score    = 0
	@penalite = 0
	@pseudo   = ""


	##
	## Vide la header bar
	##
	## @return     self
	##
	def Header.reset()
		
		@temps = 0
		@score = 0

		Fenetre::enteteFenetre.children.each do |child|
			Fenetre::enteteFenetre.remove(child)
		end

		return self
	end

	##
	## Définis le contenu de l'entête de la fenêtre
	##
	## @return     Module
	##
	def Header.profil(pseudo)

		self.reset()

		## Création du bouton de profil
		@boutonProfil = Gtk::Button.new
		image = Gtk::Image.new(:file => Core::ROOTPROJECT + "assets/img/user.png")
		
		box = Gtk::Box.new(:horizontal, 5)

		@boutonProfil.signal_connect_after("clicked")  do
			@pause = true
			Core::changeTo("Reglages", :pseudo => pseudo)
		end

		@boutonProfil.set_name("profil")
		@boutonProfil.add(image)
		box.add(@boutonProfil)

		@pseudo = pseudo

		pseudoProfil = Gtk::Label.new(pseudo.capitalize).set_name("pseudo")
		box.add(pseudoProfil)


		## Ajout au début de l'entête
		Fenetre::enteteFenetre.pack_start(box)

		return self
	end

	##
	## Définis accesseur sur l'état du jeu
	##
	## @param      Booléen de l'état
	##
	## @return     L'état de la pause
	##
	def Header.pause() 
		return @pause
	end

	##
	## Définis l'état de la pause
	##
	## @param      Booléen de l'état
	##
	## @return     L'état de la pause
	##
	def Header.pause=(bool) 
		@pause = bool
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
	## Ajoute une pénalité
	##
	## @return     self
	##
	def Header.penalite()
		@penalite += 1
		return self
	end

	##
	## Définis un mutateur pour le temps
	##
	## @return     Temps
	##
	def Header.temps=(temps)
		@temps = temps
	end

	##
	## Définis un accesseur pour le score
	##
	## @return     Temps
	##
	def Header.score()
		return @score
	end

	##
	## Définis un mutateur pour le score
	##
	## @return     Temps
	##
	def Header.score=(score)
		@score = score
	end

	##
	## Crée un chrono dans la header bar
	##
	## @return     self
	##
	def Header.chrono()
		
		Fenetre::enteteFenetre.children.each do |child|
			if(child == @tempsLabel || child == @scoreLabel)
				Fenetre::enteteFenetre.remove(child)
			end
		end

		Fenetre::enteteFenetre.pack_end(@tempsLabel)
		Fenetre::enteteFenetre.pack_end(@scoreLabel)
		
		GLib::Timeout.add_seconds(1){
				Header.addSecond
		}

		return self
	end

	##
	## Ajoute une seconde au chrono
	##
	## @return     True
	##
	def Header.addSecond()
		if(@pause == false)
			@temps += 1

			@tempsLabel.text = "Temps: " + Header.surDeuxChiffres(@temps / 60) + ":" + Header.surDeuxChiffres(@temps % 60)
			@score = @scoreModel.calcul(@penalite, @temps)
			@scoreLabel.text = "Score: " + @score.to_s
			
			return true
		end

		return false
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
