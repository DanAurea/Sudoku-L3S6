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

		dbPath = Core::ROOT + "db/"

		adapter  = @db["development"]["adapter"]
		database = dbPath + @db["development"]["database"]

		## Create a new database directory if not existing
		if !Dir.exist?(dbPath)
			if Core::DEBUG
				puts "Database directory not found, it will be created."
			end
			Dir.mkdir(dbPath)
		end

		## Create a SQLite database 
		if !File.exist?(database)
			if Core::DEBUG
				puts "SQLite3 database not found, it will be created."
			end
			SQLite3::Database.new(database)
		end

		## Set options for logging database access
		if Core::DEBUG
			Logger.new(STDERR)
		else
			Logger.new(File.open(Core::ROOT + 'log/database.log', 'w'))
		end

		## Try to connect with configuration set in files
		begin
			self.connection(adapter, database)
		rescue 

			if Core::DEBUG
				puts "Bad settings detected in configuration, Model will try to connect to database with default settings."
			end

			adapter = "sqlite3"
			database  = Core::ROOT + "db/main.sqlite3"

			self.connection(adapter, database)

		end
		
	end

	def connection(adapter, database)
		ActiveRecord::Base.establish_connection(
			:adapter  => adapter,
  		 	:database => database
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