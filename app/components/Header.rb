module Header


	##
	## Définis le contenu de l'entête de la fenêtre
	##
	## @return     Module
	##
	def Header.profil(pseudo)

		## Création du bouton de profil
		boutonProfil = Gtk::Button.new
		icon = Gio::ThemedIcon.new("mail-send-receive-symbolic")
		image = Gtk::Image.new(:icon => icon, :size => :button)

		boutonProfil.signal_connect("clicked")  do
			Core::changeTo("Reglages", :pseudo => pseudo)
		end

		boutonProfil.add(image)

		## Ajout au début de l'entête
		Fenetre::enteteFenetre.pack_start(boutonProfil)

		return self
	end

end