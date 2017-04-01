module Header


	##
	## Définis le contenu de l'entête de la fenêtre
	##
	## @return     Module
	##
	def Header.profil(pseudo)

		## Création du bouton de profil
		boutonProfil = Gtk::Button.new
		puts Core::ROOTPROJECT + "assets/doge.png"
		image = Gtk::Image.new(:file => Core::ROOTPROJECT + "assets/img/doge.png")
		
		box = Gtk::Box.new(:horizontal, 5)

		boutonProfil.signal_connect("clicked")  do
			Core::changeTo("Reglages", :pseudo => pseudo)
		end

		boutonProfil.set_name("profil")
		boutonProfil.add(image)
		box.add(boutonProfil)

		pseudoProfil = Gtk::Label.new(pseudo).set_name("pseudo")
		box.add(pseudoProfil)


		## Ajout au début de l'entête
		Fenetre::enteteFenetre.pack_start(box)

		return self
	end

end