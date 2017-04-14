require './Technique'

# => Author:: 		yguenver
# => Version:: 		0.1
# => Copyright:: 	© 2016
# => License:: 		Distributes under the same terms as Ruby


##
## Technique X-wing.
##
class XWing < Technique

	@grilleIndice

	##
	## Constructeur de la classe SCell
	##
	## @return     Une instance de la classe SCell
	##
	def XWing.creer()
		new()
	end

	##
	## Retourne la grille
	##
	## @param      grille  The grille
	##
	## @return     la grille
	##
	def rotation(grille)
		res = Array.new()

		0.upto(8) do |n|
			res.push(ligne(grille, n))
		end
		return res
	end

	##
	## Compte le nombre d'indices
	##
	## @param      lincol  The lincol
	## @param      i 
	##
	## @return   compteurS
	##
	def cptIndice(lincol, i)
		
		cpt = 0

		lincol.each do |elem|
			if( elem[i.to_s] == true )
				cpt += 1
			end
		end
		return cpt
	end


	##
	## Recherche une ligne qui remplit la condition suivante : 
	## que seulement 2 cases sur les 9 aient un indice commun que les autres n'ont pas.
	##
	## @return	res une liste de 2 lignes qui remplissent les conditions pour le même indice, nil sinon.
	##

	def findLineForIndice(i)

		res = Array.new()

		@grilleIndice.each_with_index do |line, n|
			if (cptIndice(line, i) == 2)
				res.push(n)
			end
		end
		if(res.size() >= 2)
			puts 'res : '+res.to_s+' * * * * * '+i.to_s
			return [res, i]
		end

		return nil
	end


	##
	## Cherche les emplacements d'un même indice dans une ligne (numéro de colone)
	##
	## @return	index une liste des numéros de colone
	##

	def indexIndice(ligne, indice)
		index = Array.new()
		
		@grilleIndice.each do |line|
			line.each_with_index do |elem, n|
				if(elem[indice.to_s] == true)
					index.push(n)
				end
			end
		end
		return index
	end


	##
	## Vérifie que les indices aux lignes trouvées forment un rectangle.
	##
	## @param	lignea et ligneb des numero de ligne et 
	## @param   indice 		Le nombre recherché.
	##
	## @return	true si cela donne un carré, nil sinon.
	##

	def isSquare(lignea, ligneb, indice)
		couplea = indexIndice(lignea, indice)
		coupleb = indexIndice(ligneb, indice)
		
		puts "aie aie aie"
		puts "couple a : "+couplea.to_s+"   ****"
		puts coupleb
		if (couplea == coupleb)
			return couplea
		end
		return nil
	end



	##
	## Recherche une solution pour la technique utilisée
	##
	## @param      grille  La grille
	##
	## @return     Les informations pour aider l'utilisateur, ou nul si la méthode ne trouve rien
	##

	def solution(grille)

		@grilleIndice = indice(grille)

		col = Array.new()
		line = Array.new()
		candidat = Array.new()


		1.upto(9) do |i|
			candidat = findLineForIndice(i)


			if(candidat != nil)
				
puts candidat
				col = isSquare(candidat[0][0], candidat[0][1], candidat[1])

				if(col != nil)
					puts "col : "+col.to_s
					puts "IT IS SQUARE !!!!"
					return true
				end
			end
		end


		puts line
		puts '*******'
		puts col
		puts '*******'
		
		0.upto(8){ |x|
			#puts @grilleIndice[x].to_s.gsub('nil', ' ')
		}

		
		return nil
	end

end



xwing = XWing.creer()

grille = [
['4','3',nil,'2','5','8','7','1',nil],
[nil,nil,'1','7','6','3','5',nil,'4'],
[nil,'5',nil,'1','4','9','3',nil,nil],

[nil,nil,'4',nil,'3','7','9','6','1'],
[nil,'7',nil,nil,'1','2','8','4','3'],
['1',nil,'3',nil,'9','4','2','7','5'],

[nil,'1','8','3','7','6','4','5',nil],
[nil,nil,nil,'4','2','5','1',nil,nil],
[nil,'4',nil,'9','8','1','6',nil,'7']]

xwing.solution(grille)

grillerot = xwing.rotation(grille)

xwing.solution(grillerot)

