require 'sqlite3'
require 'singleton'
require_relative 'Conf.rb'

class Model
	include Singleton

	attr_accessor :db

	def initialize
		## Retrieving configuration from yaml files
		@conf = Conf.instance()
		
		@app    = @conf.app
		@dbConf = @conf.db
		@@db     = nil

		dbPath = Core::ROOT + Core::DEFAULT_DATABASE_DIR

		database = dbPath + @dbConf["development"]["database"]

		self.mkDatabaseDir(dbPath)
		self.connection(database)
		
	end

	##
	## @brief      Create a new database directory
	##
	## @param      dbPath  The database path
	##
	## @return     Itself
	##
	def mkDatabaseDir(dbPath)
		## Create a new database directory if not existing
		if !Dir.exist?(dbPath)
			if Core::DEBUG
				puts "Database directory not found, it will be created."
			end
			Dir.mkdir(dbPath)
		end

		return self
	end


	##
	## @brief      Connect to a database
	##
	## @param      database  The database
	##
	## @return     Itself
	##
	def connection(database)
		## Create a SQLite database 
		if !File.exist?(database)
			if Core::DEBUG
				puts "SQLite3 database not found, it will be created."
			end
			begin 
				SQLite3::Database.new(database)
			rescue SQLite3::Exception => e
				puts "SQLite3 couldn't create a new database."
			end
		end
		
		## Connect to created dtabase
		@@db = SQLite3::Database.open(database)

		return self
	end

	##
	## @brief      Invoke methods when inherited
	##
	## @param      subclass  The subclass
	##
	## @return     Itself
	##
	def self.inherited(subclass)
		iparent = self.instance()
		super

		return self
	end


	##
	## @brief      Insert datas in database
	##
	## @param      options  Hash with columns and values
	##
	## @return     Itself
	##
	def insert(**options)
		colsName = Array.new 
		values = Array.new

		## Parse options to get columns and values
		options.each do |index, value|
			colsName << index

			## Puts quotes around string value
			if(value.class == String)
				value = "\'" + value + "\'"
			end

			values << value
		end

		colsName = colsName.join(",")
		values = values.join(",")

		@@db.execute "INSERT INTO " + self.class.to_s.downcase + " (#{colsName}) 
				VALUES (#{values});"

		return self
	end

end