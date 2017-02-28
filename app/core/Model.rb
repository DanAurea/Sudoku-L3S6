require 'active_record'
require 'sqlite3'
require 'singleton'
require 'core/Conf.rb'

class Model
	include Singleton

	def initialize
		## Retrieving configuration from yaml files
		@conf = Conf.instance()
		
		@app  = @conf.app
		@db   = @conf.db

		adapter = @db["development"]["adapter"]
		dbPath  = Core::ROOT + @db["development"]["database"]

		## Create a SQLite database 
		if !File.exist?(dbPath)
			SQLite3::Database.new(dbPath)
		end

		## Set options for logging database access
		if Core::DEBUG
			logger = Logger.new(STDERR)
		else
			logger = Logger.new(File.open(Core::ROOT + 'log/database.log', 'w'))
		end

		## Try to connect with configuration set in files
		begin
			self.connection(adapter, dbPath)
		rescue 

			if Core::DEBUG
				puts "Bad settings detected in configuration, Model will try to connect to database with default settings."
			end

			adapter = "sqlite3"
			dbPath  = Core::ROOT + "db/main.sqlite3"

			self.connection(adapter, dbPath)

		end
		
	end

	def connection(adapter, dbPath)
		ActiveRecord::Base.establish_connection(
			:adapter  => adapter,
  		 	:database => dbPath
		)
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