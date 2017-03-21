$LOAD_PATH << '.'

require 'core/Core'
require 'core/Controller.rb'
require 'core/Model.rb'
require 'gtk3'

Gtk::init()

require 'view/Fenetre.rb'
require 'core/View.rb'

## Charge la page principale du jeu
Core::changeTo("Principale")

Gtk::main()
