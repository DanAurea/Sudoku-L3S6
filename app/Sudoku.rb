$LOAD_PATH << '.'

require 'core/Core'
require 'core/Controller.rb'
require 'core/Model.rb'
require 'core/View.rb'
require 'gtk2'

Gtk::init()

## Charge la page principale du jeu
Core::load("Principale")

Gtk::main()