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

	end

	def majUtilisateur(**args)

	end

	def supprimerUtilisateur(pseudo)

	end
	
	def rechercherUtilisateur(pseudo)

	end

	def filtreUtilisateur(**args)

	end	

end