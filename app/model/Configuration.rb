# 	Modele de la configuration
# 	
# 	Author:: 		DanAurea
# 	Developers: 	DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# Declaration de la table contenant les paramètres
#
class Configuration < Model

	def initialize()
		
		## Crée la table utilisateur
		ActiveRecord::Schema.define do
			unless ActiveRecord::Base.connection.data_sources.include? 'configuration'
				create_table :configuration do |table|
 					table.column :utilisateur_id, :integer
 					table.column :taille_police, :integer
 					table.column :police, :string
 					table.column :couleur, :string
		    	end
			end
		end

	end

end