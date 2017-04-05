# => Author::       DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby

##
## =Visualization of the data that model contains.
##
class View
	include Fenetre

	attr_accessor :headerBar, :window, :controller
	attr_writer :content

	def initialize()
		@content    = Hash.new()
		@controller = nil
		@window     = Fenetre::fenetre
		@headerBar  = Fenetre::enteteFenetre
	end

	##
	## Invoke methods when inherited
	##
	## @param      subclass  The subclass
	##
	## @return     Itself
	##
	def self.inherited(subclass)
		self.new()
		super

		return self
	end

	##
	## Create instance variables from @content provided by controller.
	##
	## @return 		Itself
	def setInstanceVars ()
		@content.each { |name, value| instance_variable_set("@" + name, value) }

		return self
	end


	##
	## Invoke all methods from view
	##
	def run()
		if Core::DEBUG
			raise "View #{self.class.name} can't be build because run method is not redefined."		
		end
	end

end