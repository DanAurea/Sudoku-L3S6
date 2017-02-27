$LOAD_PATH << '.'

require 'core/Core'
require 'core/Controller.rb'
require 'core/Model.rb'
require 'gtk2'

Gtk::init()

require 'view/Fenetre.rb'
require 'core/View.rb'

## Charge la page principale du jeu
Core::load("Principale")

Gtk::main()