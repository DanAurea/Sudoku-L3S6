class Utilisateur < Model

	def initialize()
		
		## Crée la table utilisateur
		ActiveRecord::Schema.define do
			unless ActiveRecord::Base.connection.data_sources.include? 'utilisateur'
				create_table :utilisateur do |table|
					table.column :utilisateur_id, :integer
 					table.column :pseudo,     :string
		    	end
			end
		end

	end

	def CreerUtilisateur(pseudo)
		return self.create(pseudo: pseudo)
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

end