# 	File description
# 	
# 	Author:: 		DanAurea
# 	Developers: 	DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 	
# 	Class description
#
class FenetreReglages < View

	def initialize()
		
	end

	def miseEnPlace()
    	Fenetre::table.attach(Fenetre::creerLabelType("Pseudo : #{@pseudo.capitalize}", 15, "#FF0000"),7,10,0,1)
    	Fenetre::table.attach(Fenetre::creerLabelType("<u>Réglages</u>", 40, "#FFFFFF"),0,10,1,2)

        #Creation des Boutons
        frame1 = Gtk::Frame.new(" Choix taille des chiffres ")
        frame1.shadow_type = Gtk::SHADOW_ETCHED_OUT

        tableTaille=Gtk::Table.new(4,1,false)
        boutonPetitChiffre = Gtk::RadioButton.new("Petit Chiffre")
        boutonGrandChiffre = Gtk::RadioButton.new(boutonPetitChiffre,"Grand Chiffre")
        #tableTaille.attach(Gtk::Image.new(CHEMIN_IMAGE_PETIT_CHIFFRE_REGLAGE),0,1,0,1)
        tableTaille.attach(boutonPetitChiffre,1,2,0,1)
        #tableTaille.attach(Gtk::Image.new(CHEMIN_IMAGE_GRAND_CHIFFRE_REGLAGE),2,3,0,1)
        tableTaille.attach(boutonGrandChiffre,3,4,0,1)
        frame1.add(tableTaille)

        frame2 = Gtk::Frame.new(" Choix de la couleur ")
        frame2.shadow_type = Gtk::SHADOW_ETCHED_OUT
        tableCouleur=Gtk::Table.new(8,2,false)
        
        boutonBlanc = Gtk::RadioButton.new("Blanc")
        boutonBleu = Gtk::RadioButton.new(boutonBlanc,"Bleu")
        boutonJaune = Gtk::RadioButton.new(boutonBlanc,"Jaune")
        boutonOrange = Gtk::RadioButton.new(boutonBlanc,"Orange")
        boutonRouge = Gtk::RadioButton.new(boutonBlanc,"Rouge")
        boutonTurquoise = Gtk::RadioButton.new(boutonBlanc,"Turquoise")
        boutonVert = Gtk::RadioButton.new(boutonBlanc,"Vert")
        boutonViolet = Gtk::RadioButton.new(boutonBlanc,"Violet")

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_BLANC_REGLAGE),0,1,0,1)
        tableCouleur.attach(boutonBlanc,1,2,0,1)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_BLEU_REGLAGE),2,3,0,1)
        tableCouleur.attach(boutonBleu,3,4,0,1)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_JAUNE_REGLAGE),4,5,0,1)
        tableCouleur.attach(boutonJaune,5,6,0,1)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_ORANGE_REGLAGE),6,7,0,1)
        tableCouleur.attach(boutonOrange,7,8,0,1)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_ROUGE_REGLAGE),0,1,1,2)
        tableCouleur.attach(boutonRouge,1,2,1,2)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_TURQUOISE_REGLAGE),2,3,1,2)
        tableCouleur.attach(boutonTurquoise,3,4,1,2)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_VERT_REGLAGE),4,5,1,2)
        tableCouleur.attach(boutonVert,5,6,1,2)

        # tableCouleur.attach(Gtk::Image.new(CHEMIN_IMAGE_VIOLET_REGLAGE),6,7,1,2)
        tableCouleur.attach(boutonViolet,7,8,1,2)

        tableCouleur.set_row_spacing(0, 10)
        tableCouleur.set_row_spacing(1, 10)
        frame2.add(tableCouleur)

        boutonRetour=Gtk::Button.new(Gtk::Stock::GO_BACK)
        boutonRetour.signal_connect('clicked'){
        	Fenetre::fenetrePrecedente()
        }

        boutonQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
        boutonQuitter.signal_connect('clicked'){
        	Fenetre::detruire()
        }

        Fenetre::table.attach(frame1,2,8,2,4)
        Fenetre::table.attach(frame2,1,9,5,9)
        Fenetre::table.attach(boutonRetour,1,3,11,12)
        Fenetre::table.attach(boutonQuitter,7,9,11,12)
        Fenetre::table.attach(Fenetre::creerFondEcran(900,500),0,10,0,12)
    end

	def run()
		self.miseEnPlace()
		return self
	end

end