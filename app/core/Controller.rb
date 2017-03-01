
##
## @brief      Controls the data flow into an item object and updates the view whenever data changes.
##
class Controller

	def initialize ()

		@title       = "MyApp"
		@width       = 900
		@height      = 500
		@borderWidth = 0
		@resizable   = false
		@position 	 = "POS_CENTER_ALWAYS"

		if Core::DEBUG
			puts "Main controller instanciation"
		end
	end


	##
	## @brief      Invoke methods when inherited
	##
	## @param      subclass  The subclass
	##
	## @return     Itself
	##
	def self.inherited(subclass)
		super

		return self
	end

	##
	## @brief      Loads a file.
	##
	## @param      filePath   The file path
	## @param      debugInfo  The debug information
	##
	## @return     Itself
	##
	def loadFile(filePath, debugInfo)
		begin
			require filePath
		rescue LoadError
			
			if Core::DEBUG
				puts debugInfo + ": " + File.basename(filePath) + " not found in " + Core::ROOT + debugInfo.downcase
			end

			exit(1) 
		end

		return self
	end

	##
	## @brief      Render view called by controller
	##
	## @param      name  The view to render
	##
	##
	def render(name)
		if Core::DEBUG
			puts "Loading view..."
		end

		name = Core::VIEW + Core::format(name)

		filePath = Core::viewPath(name)

		self.loadFile(filePath, "View")

		## Create content variable sent from controller to view called
		@content = Hash.new()

		## Will retrieve class constant name for dynamic instanciation
		viewName = Object.const_get(name)

		view = viewName.new()

		## Set window properties
    	
    	view.window.set_title(@title)
    	view.window.set_default_size(@height, @width)
    	view.window.border_width = @borderWidth
    	view.window.set_resizable(@resizable)
    	view.window.set_window_position(Object.const_get("Gtk::Window::" + @position))

    	# view.window.set_window_position(Gtk::Window::@position)
		
		## Collect content from controller and send it to view
		view.controller = self
		view.controller.run()
		view.content    = @content.clone()

		## Refer controller methods in view for easier
		## call.
		self.class.instance_methods(false).each() do |method|
			if !view.class.method_defined?(method)
				view.define_singleton_method(method) do |*args|
					self.controller.send(method, *args)
				end
			end
		end

		## Will render view with content retrieved in controller
		view.setInstanceVars()
		view.run()

		## Display content builded in view with Gtk
		view.window.show_all
	end

	##
	## @brief      Loads a model.
	##
	## @param      name  The model to load
	##
	## @return     Model instance
	##
	def loadModel(name)
		name = Core::format(name)

		filePath = Core::modelPath(name)

		self.loadFile(filePath, "Model")

		## Will retrieve class constant name for dynamic instanciation
		modelName = Object.const_get(name)

		## Make an only one instance of model (Singleton pattern)
		## to ensure date integrity.
		model = modelName.instance()

		self.instance_variable_set("@" + name, model)

		return model

	end

	## @brief      Invoke all method in controller for collecting
	## 				contents to send on view. 
	##
	##
	def run()
		if Core::DEBUG
			raise "Controller #{self.class.name} can't collect content because run method is not redefined."
		end
	end

end