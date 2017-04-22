require 'sqlite3'
require 'singleton'
require_relative 'Conf.rb'

# => Author::       DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## Classe permettant de gérer la base de données sqlite3
##
class Model
	include Singleton

	attr_accessor :db

	##
	## Initialisation
	##
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
	## Create a new database directory
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
	## Connect to a database
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
	## Invoke methods when inherited
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

	##
	## Insert datas in database
	##
	## @param      options  Hash with columns and values
	##
	## @return     Itself
	##
	def insert(**options)
		colsName = Array.new 
		values   = Array.new
		bonds    = Array.new

		## Parse options to get columns and values
		options.each do |index, value|
			colsName << index
			values << value
			bonds << "?"
		end

		colsName = colsName.join(",")
		bonds = bonds.join(",")

		if Core::DEBUG
			puts "Request: INSERT INTO " + self.class.to_s.downcase + " (#{colsName}) VALUES (#{bonds});"
			
			print "Values was: "
			options.each do |index, value|
				print "#{index} => #{value} | "
			end

			puts
			puts
		end

		@@db.execute "INSERT INTO " + self.class.to_s.downcase + " (#{colsName}) 
				VALUES (#{bonds});", values

		return self
	end

	##
	## Convert an array reques to a hash with columns => values
	##
	## @param      req   The request
	##
	## @return     Request hashed
	##
	def to_h(req)
		response = Array.new()

		## Transforme la réponse en hash
		(1...req.length).each do |row|
			response[row-1] = Hash.new()
			(0...req[0].length).each do |col|
				response[row-1][req[0][col]] = req[row][col]
			end
		end

		return response
	end

end