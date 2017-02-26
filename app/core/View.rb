
##
## @brief      Visualization of the data that model contains.
##
class View

	attr_accessor :content, :window

	def initialize()
		@content = Hash.new()
	end

	##
	## @brief      Create instance variables from 
	## 				@content. 
	##
	##
	def contentInstanceVariables ()
		@content.each { |name, value| instance_variable_set("@" + name, value) }
	end

end