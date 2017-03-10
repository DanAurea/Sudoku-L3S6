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
	
	def rechercherUtilisateur()
		puts "pseudo"
	end

	def pseudoExiste(pseudo)
		return true
	end	

end