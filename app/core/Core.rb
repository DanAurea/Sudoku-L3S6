module Core

	## Define root directory constant
	ROOT                  = File.dirname(File.dirname(__FILE__)) + "/"
	ROOTPROJECT           = File.dirname(ROOT) + "/"
	CONTROLLER            = "Controleur"
	VIEW                  = "Fenetre"
	DEBUG                 = true
	DEFAULT_DATABASE_LOG  = "log/main.log"
	DEFAULT_ADAPTER       = "sqlite3"
	DEFAULT_DATABASE_DIR  = "db/"
	DEFAULT_DATABASE_NAME = "main.sqlite3"

	@previousWindow = nil
	@args           = nil

	##
	## @brief      Load a controller and render its view
	##
	## @param      name  The name
	##
	## @return     Module itself
	##
	def Core.load(name, **args)

		controller = loadController(name)

		controller.render(name, args)

		return self
	end

	##
	## @brief      Change window
	##
	## @param      name  The name
	##
	## @return     Module itself
	##
	def Core.changeTo(name, **args)
		
		if(args.has_key?(:caller))
			puts args[:caller]
		end

		## Retrieve class caller
		caller = File.basename(caller_locations.first.path)
		
		if(caller.include?(VIEW))
			caller.slice!(VIEW)
		elsif(caller.include?(CONTROLLER))
			caller.slice!(CONTROLLER)
		end

		caller.slice!(".rb")

		## Save caller window
		@previousWindow = caller
		@args = args

		## Create a new empty window
		Fenetre::fenetrePrecedente = Fenetre::fenetre.children.clone()
		Fenetre::viderFenetre
		Fenetre::miseEnPlace()

		load(name, args)

		return self
	end


	##
	## @brief      Back to previous window
	##
	## @return     Module itself
	##
	def Core.back()
		self.changeTo(@previousWindow, @args)

		return self
	end

	##
	## @brief      Give model path for 
	##				model called.
	##
	## @param      name  The name
	##
	## @return     Model path
	##
	def Core.modelPath(name)
		return ROOT + "model/" + name + ".rb"
	end

	##
	## @brief      Give view path for
	## 				view called.
	## @param      name  The name
	##
	## @return     View path
	##
	def Core.viewPath(name)
		return ROOT + "view/" + name + ".rb"
	end

	##
	## @brief      Give controller path for
	## 				controller called.
	##
	## @param      name  The name
	##
	## @return     Controller path
	##
	def Core.controllerPath(name)
		return ROOT + "controller/" + name + ".rb"
	end


	##
	## @brief      Force children overriding constructor
	## 				inherited from parent class to run 
	## 				parent constructor.
	##
	## @return     Itself
	##
	def Core.forceParentInit(o)
		
		## Force to call parent method if children override it
		if o.method(:initialize).owner != o.class.name
			o.method(:initialize).super_method.call
			o.method(:initialize).call
		end

	end

	##
	## @brief      Loads a controller.
	##
	## @param      name  The controller to load
	##
	## @return     Controller instance
	##
	def Core.loadController(name)
		
		name = name + CONTROLLER

		## Define file path for controller
		filePath = self.controllerPath(name)

		begin
			require filePath
		rescue LoadError
			
			if DEBUG
				puts "Controller: " + name + " not found in " + ROOT + "controller"
			end

			exit(1) 
		end

		## Will retrieve class constant name for dynamic instanciation
		controllerName = Object.const_get(name)

		controller = controllerName.new()		

		return controller
	end

	## Define a class from module itself for declaring private methods
	class << self
    	private :loadController, :load
  	end

end