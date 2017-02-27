require 'active_record'
require 'singleton'

class Model  #< ActiveRecord::Base
	include Singleton

	def initialize
		## Se connecter à SQLite3
		## Charger les config avec YAML dans une variable d'instance @config
	end

	##
	## @brief      Invoke methods when inherited
	##
	## @param      subclass  The subclass
	##
	## @return     Itself
	##
	def self.inherited(subclass)
		self.instance()
		super

		return self
	end

end