$LOAD_PATH << '.'

require_relative 'core/Core'
require_relative 'core/Controller.rb'
require_relative 'core/Model.rb'
require 'gtk3'

Gtk::init()

require_relative 'view/Fenetre.rb'
require_relative 'core/View.rb'

## Charge la page principale du jeu
Core::changeTo("Principale")

Gtk::main()
