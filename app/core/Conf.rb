require "yaml"

# => Author::       DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## Classe permettant de gérer le core (configuration unique)
##

class Conf
	include Singleton

	attr_reader :app, :db

	##
	## Initialisation
	##
	def initialize ()
		## TODO: Add some exceptions handling
		@app  = YAML.load_file(Core::ROOT + "config/app.yml")
		@db   = YAML.load_file(Core::ROOT + "config/database.yml")
	end
	
end