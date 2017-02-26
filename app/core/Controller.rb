
##
## @brief      Controls the data flow into an item object and updates the view whenever data changes.
##
class Controller

	def initialize ()
		if Core::DEBUG
			puts "Main controller instanciation"
		end
	end


	##
	## @brief      Render view called by controller
	##
	## @param      name  The name
	##
	##
	def render(name)
		if Core::DEBUG
			puts "Loading view..."
		end

		name = Core::VIEW + Core::format(name)

		filePath = Core::viewPath(name)

		begin
			require filePath
		rescue LoadError
			
			if Core::DEBUG
				puts "View: " + name + " not found in " + Core::ROOT + "view"
			end

			exit(1) 
		end

		## Create content variable to send from controller to view called
		@content = Hash.new()

		@window  = Gtk::Window.new()

		## Will retrieve class constant name for dynamic instanciation
		viewName = Object.const_get(name)

		view = viewName.new()

		## Send content and window context to view called
		view.content = @content.clone()
		view.window  = @window

		@window.signal_connect('destroy') {
  			Gtk.main_quit
		}

		@window.show_all
	end


	##
	## @brief      Loads a model.
	##
	## @param      name  The name
	##
	## @return     Model instance
	##
	def loadModel(name)
		name = Core::format(name)

		filePath = Core::modelPath(name)

		begin
			require filePath
		rescue LoadError
			
			if Core::DEBUG
				puts "Model: " + name + " not found in " + CORE::ROOT + "model"
			end

			exit(1) 
		end

		## Will retrieve class constant name for dynamic instanciation
		modelName = Object.const_get(name)

		model = modelName.new()

		return model

	end
end