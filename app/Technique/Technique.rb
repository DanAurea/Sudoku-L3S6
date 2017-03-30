

##
## @brief      Classe pour technique, aidant l'utiliateur à la résolution d'un Sudoku.
##
class Technique{
	
	private_class_method new:

	##
	## @brief      Constructeur de la classe Technique
	##
	## @return     Une instance de la classe Technique
	##
	def Technique.creer()
		new()
	end


	##
	## @brief      Recherche une solution pour la technique utilisée
	##
	## @param      grille  La grille
	##
	## @return     Les informations pour aider l'utilisateur, ou nul si la méthode ne trouve rien
	##
	def solution(grille)
		return nil
	end

	##
	## @brief      Calcul les candidats pour une grille donnée
	##
	## @param      grille  La grille
	##
	## @return     Un tableau de tableau d'Hashmap 
	##
	def indice(grille)
		grilleIndice = Array.new(9){Array.new(9){Hash.new()}}

		grille.each { |col,x|
			col.each { |c,y|
				if c.nil? then
					[1,2,3,4,5,6,7,8,9].each { |numero|
						unless estProtegee(grille,numero.to_s,x,y) then
							grilleIndice[x][y][numero.to_s] = true
						else
							grilleIndice[x][y][numero.to_s] = false
						end
					}
				end
			}
		}

		return grilleIndice
	end
	
	##
	## @brief      Recherche dans la grille les numeros déjà présents
	##
	## @param      grille  La grille
	## @param      numero  Le numero
	##
	## @return     La liste des coordonnées des numeros déjà présents
	##
	def nombreDejaPresent(grille, numero)
		listPresent = Array.new(9) {nil}
		[1,4,7].each{ |x|
			[1,4,7].each{ |y|
				-1.upto(1){ |xbis|
					-1.upto(1){ |ybis|
						if numero.to_s == grille[x+xbis][y+ybis] then
							listPresent[numero-1]=grille[x+xbis][y+ybis]
						end
					}
				}
			}
		}
		return listPresent
	end

	##
	## @brief      Récupère un block de 9 d'une grille de Sudoku
	##
	## @param      grille  La grille
	## @param      num     Le numero du block
	##
	## @return     Un tableau d'un tableau de 3 par 3
	##
	def block(grille, num)
		res = Array.new()

		x = ((num-1)*3)%9
		y = num/3*3

		grille[x..x+2].each{ |col|
			res << col[y..y+2]
		}

		return res
	end

	##
	## @brief      Récupère la colonne x dans la grille
	##
	## @param      grille  La grille
	## @param      x       La colonne
	##
	## @return     La colonne
	##
	def colonne(grille, x)
		return grille[x]
	end

	##
	## @brief      Récupère la ligne y dans la grille
	##
	## @param      grille  La grille
	## @param      y       La ligne
	##
	## @return     La ligne
	##
	def ligne(grille, y)
		res = Array.new()
		grille.each{ |col|
			res << col[y]
		}
		return res
	end

	##
	## @brief      Vérifie si une case est protégé pour un numéro donnée
	##
	## @param      grille  La grille
	## @param      num     Le numero
	## @param      x       La colonne de la case
	## @param      y       La ligne de la case
	##
	## @return     True si elle est protégée, false sinon
	##
	def estProtegee?(grille, num, x, y)

		ligne = ligne(grille, y)
		colonne = colonne(grille, x)
		block = block(grille, aQuelBloc(x,y))


		ligne.each{ |cBis|
			if num == cBis then
				return true
			end
		}
		colonne.each{ |cBis|
			if num == cBis then
				return true
			end
		}
		block.each{ |col|
		 	col.each{ |cBis|
				if num == cBis then
					return true
				end
			}
		}

		return false
	end

	##
	## @brief      Recherche le numero du block auquel appartient une case donnée
	##
	## @param      x     La colonne de la case
	## @param      y     La ligne de la case
	##
	## @return     Le numero du block
	##
	def aQuelBloc(x,y)
		return ((x/3)+1)+(y/3*3)
	end

}




