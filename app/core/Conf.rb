require "yaml"

class Conf
	include Singleton

	attr_reader :app, :db

	def initialize ()
		## TODO: Add some exceptions handling
		@app  = YAML.load_file(Core::ROOT + "config/app.yml")
		@db   = YAML.load_file(Core::ROOT + "config/database.yml")
	end
	
end