require_relative "CaseDessin.rb"
require "observer"

class GrilleDessin < Gtk::Grid
    include Observable
    
    def initialize valeurs
        
        super() 

        ## TODO: Lire largeur et hauteur dans un fichier de config
        @largeurCase = 40 
        @hauteurCase = 40
        
        @valeurs     = valeurs     
        @cases       = Array.new()
        @nbCases     = 9

        signal_connect "draw" do |widget, cr|
            dessiner cr
        end

        colonne = 0
        ligne   = 0

        largeurCol = 1
        hauteurLig = 1

        @valeurs.each do | section |
        
            section.each do | valeur |
                c = CaseDessin.new valeur
                c.add_observer(self)

                @cases << c

                attach c, colonne, ligne , largeurCol, hauteurLig

                if colonne == 8
                    colonne  = 0
                    ligne   += 1 
                else
                    colonne += 1
                end
            end

        end
    end

    def update(caseObj)
        x = @cases.index(caseObj) / 9
        y = @cases.index(caseObj) % 9
    end

    def dessiner cr

        ## TODO: Définir une largeur de case et fenêtre par défaut chargé
        ## à partir d'un fichier de config en variables d'instances
        @largeurCase = (25 * toplevel.allocated_width  / 600).round
        @hauteurCase = @largeurCase

        colonne = 0
        ligne   = 0

        @cases.each do | c |

            c.largeur = @largeurCase
            c.hauteur = @hauteurCase
            c.taillePolice = @largeurCase / 3

            c.x = colonne * @largeurCase
            c.y = ligne * @hauteurCase
            c.dessiner cr

            if colonne == 8
                colonne  = 0
                ligne   += 1 
            else
                colonne += 1
            end
        end

        largeurLigne = @nbCases * @largeurCase
        hauteurLigne = @nbCases * @hauteurCase
        
        set_size_request largeurLigne , hauteurLigne

        largeurBordureExt = 4

        cr.set_source_rgb 0.0 , 0.0, 0.0

        ## Calcule le chemin du contour
        cr.move_to 0, 0
        cr.set_line_width largeurBordureExt

        cr.rel_line_to largeurLigne, 0
        cr.rel_line_to 0, hauteurLigne
        cr.rel_line_to -largeurLigne, 0
        cr.rel_line_to 0, -hauteurLigne

        ## Calcule le chemin des délimitations
        cr.move_to 3 * @largeurCase, 0
        cr.rel_line_to 0, hauteurLigne

        cr.move_to 6 * @largeurCase, 0
        cr.rel_line_to 0, hauteurLigne

        cr.move_to 0, 3 * @hauteurCase
        cr.rel_line_to largeurLigne, 0

        cr.move_to 0, 6 * @hauteurCase
        cr.rel_line_to largeurLigne, 0

        ## Dessine les lignes à partir des chemins calculés précédemment
        cr.stroke

        return self
    end

end
