# => Author:: 		yguenver
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby

##
## Classe Technique, aidant l'utiliateur à la résolution d'un Sudoku.
##
class Technique
	
	##
	## Constructeur de la classe Technique
	##
	## @return 	Une instance de la classe Technique
	##
	def Technique.creer()
		new()
	end


	##
	## Recherche une solution pour la technique utilisée
	##
	## @param  	grille 			La grille
	##
	## @return 	res, les informations pour aider l'utilisateur ou nil si la méthode ne trouve rien
	##
	def solution(grille)
		return nil
	end

	##
	## Calcule les candidats pour une grille donnée
	## Retourne le nombre d'étape pour faire la technique
	##
	## @return     Le nombre d'étape(s)
	##
	def combienEtape()
		return nil
	end


	##
	## Retourne les étapes pour faire la technique
	##
	## @param      n     Le numéro de la technique
	##
	## @return     Le nombre d'étape si n=0, un text expliquant l'étape sinon
	##
	def etape(n)
		return nil
	end


	private # Les méthodes suivantes sont privées

	##
	## Calcul les candidats pour une grille donnée
	##
	## @param 	grille 			La grille
	##
	## @return 	grilleIndice, un tableau de tableau d'Hashmap 
	##
	def indice(grille)
		grilleIndice = Array.new(9){Array.new(9){Hash.new()}}

		grille.each_with_index { |col,x|
			col.each_with_index { |c,y|
				if c.nil? then
					[1,2,3,4,5,6,7,8,9].each { |numero|
						unless estProtegee?(grille,numero.to_s,x,y) then
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
	## Recherche dans la grille les numéros déjà présents
	##
	## @param 	grille 			La grille
	## @param 	numero 			Le numéro
	##
	## @return 	listPresent, la liste des coordonnées des numéros déjà présents
	##
	def nombreDejaPresent(grille, numero)
		listPresent = Array.new(9) {nil}
		[0,1,2,3,4,5,6,7,8].sort_by{rand}.each{ |x|
			[0,1,2,3,4,5,6,7,8].sort_by{rand}.each{ |y|
				if numero.to_s == grille[x][y] then
					listPresent[numero-1]=grille[x][y]
				end
			}
		}
		return listPresent
	end

	##
	## Récupère un bloc de 9 cases d'une grille de Sudoku
	##
	## @param 	grille 			La grille
	## @param 	num 			Le numero du block
	##
	## @return 	res, un tableau d'un tableau de 3 par 3
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
	## Récupère la colonne x dans la grille
	##
	## @param 	grille 			La grille
	## @param 	x 				La colonne
	##
	## @return     grille[x], la colonne
	##
	def colonne(grille, x)
		return grille[x]
	end

	##
	## Récupère la ligne y dans la grille
	##
	## @param 	grille 			La grille
	## @param  	y 				La ligne
	##
	## @return res, la ligne
	##
	def ligne(grille, y)
		res = Array.new()
		grille.each{ |col|
			res << col[y]
		}
		return res
	end

	##
	## Vérifie si une case est protégée pour un numéro donnée
	##
	## @param 	grille 			La grille
	## @param 	num 			Le numero
	## @param 	x 				La colonne de la case
	## @param 	y 				La ligne de la case
	##
	## @return 	True si elle est protégée, false sinon
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
	## Recherche le numéro du bloc auquel appartient une case donnée
	##
	## @param 	x 				La colonne de la case
	## @param 	y 				La ligne de la case
	##
	## @return 	Le numero du bloc
	##
	def aQuelBloc(x,y)
		return ((x/3)+1)+(y/3*3)
	end

end
