# => Author:: 		Valentin, DanAurea
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby

 ##
 ## Module permettant de 
 ##

module Core

	## Définit le répertoire de la racine
	ROOT                  = File.expand_path(File.dirname(File.dirname(__FILE__))) + "/"
	## Définit la racine du projet
	ROOTPROJECT           = File.dirname(ROOT) + "/"
	## Définit le contrôleur
	CONTROLLER            = "Controleur"
	## Définit la vue
	VIEW                  = "Fenetre"
	## Définit le mode debug
	DEBUG                 = false
	## Définit le log de la base de données
	DEFAULT_DATABASE_LOG  = "log/main.log"
	## Définit la base de données
	DEFAULT_ADAPTER       = "sqlite3"
	## Définit le répertoire de la base de données
	DEFAULT_DATABASE_DIR  = "db/"
	## Définit le fichier où contiennent les éléments de la base de données
	DEFAULT_DATABASE_NAME = "main.sqlite3"

	@previousWindow = Array.new()
	@args           = nil

	##
	## Load a controller and render its view
	##
	## @param 	name 			The name
	##
	## @return 	Module itself
	##
	def Core.load(name, **args)

		controller = loadController(name)

		controller.render(name, args)

		return self
	end

	##
	## Change window
	##
	## @param 	name 			The name
	##
	## @return 	Module itself
	##
	def Core.changeTo(name, **args)

		## Prevent some issue with back option
		## no more loop possible when caller is 
		## identical as destination.
		## Act like an Ariane's thread we
		## can now back on all previous windows.
		if @previousWindow.slice(-1) != name
			## Save caller window
			@previousWindow << name
		end
		
		@args = args

		## Create a new empty window
		Fenetre::fenetrePrecedente = Fenetre::fenetre.children.clone()
		Fenetre::viderFenetre

		load(name, args)

		return self
	end


	##
	## Back to previous window
	##
	## @return 	Module itself
	##
	def Core.back()
		if @previousWindow.length > 1
			## Slice current page
			@previousWindow.slice!(-1)
			## Go back to previous window
			self.changeTo(@previousWindow.slice!(-1), @args)
		else
			puts "Empty stack, you can't back to a non stacked window."
		end

		return self
	end

	##
	## Give model path for model called.
	##
	## @param 	name 			The name
	##
	## @return 	Model path
	##
	def Core.modelPath(name)
		return ROOT + "model/" + name + ".rb"
	end

	##
	## Give view path for view called.
	## 
	## @param 	name 			The name
	##
	## @return 	View path
	##
	def Core.viewPath(name)
		return ROOT + "view/" + name + ".rb"
	end

	##
	## Give controller path for controller called.
	##
	## @param 	name 			The name
	##
	## @return 	Controller path
	##
	def Core.controllerPath(name)
		return ROOT + "controller/" + name + ".rb"
	end


	##
	## Force children overriding constructor inherited from parent class to run parent constructor.
	##
	## @return 	Itself
	##
	def Core.forceParentInit(o)
		
		## Force to call parent method if children override it
		if o.method(:initialize).owner != o.class.name
			o.method(:initialize).super_method.call
			o.method(:initialize).call
		end

	end

	##
	## Loads a controller.
	##
	## @param 	name 			The controller to load
	##
	## @return 	Controller instance
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