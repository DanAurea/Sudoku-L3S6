class Utilisateur < Model

	def initialize()
		
		## Crée la table utilisateur
		@@db.execute  "CREATE TABLE IF NOT EXISTS utilisateur (
						id integer primary key autoincrement,
						pseudo varchar(30)
						);"
	end

	def creerUtilisateur(pseudo)
		insert(:pseudo => pseudo)
		return self
	end

	def majUtilisateur(**args)
		self.update(args)
	end

	def supprimerUtilisateur(pseudo)
		if self.where(pseudo: pseudo).delete(1) != nil
			return true
		else
			return false
		end
	end
	
	def rechercherUtilisateur(pseudo)
		return self.find_by(pseudo: pseudo)
	end

	def filtreUtilisateur(**args)
		return self.where(**args)
	end	

	def partieUtilisateur?(pseudo)
		return File.exist?("assets/save"+pseudo)
	end
end