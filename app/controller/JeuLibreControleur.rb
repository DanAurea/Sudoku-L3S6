# => Controlleur vue jeu libre
# => Author::       Valentin, DanAurea
# => Version::      0.1
# => Copyright::    © 2016
# => License::      Distributes under the same terms as Ruby
# 	
 	
# 	Class JeuLibreControleur

class JeuLibreControleur < Controller

	##
    ## Initialize
    ##
	def initialize()
		#charge le modele grille
		loadModel("Configuration")
		loadModel("Grille")
		loadModel("Score")
		loadModel("Jeu")

		#parametres fenetre
		@title   = "Sudoku - Jeu Libre"
		@content = {"grille" => nil}
		@height   = 720
	end


	##
	## Met à jour la grille de données
	##
	## @param      x      Position x de la case
	## @param      y      Position y de la case
	## @param      value  La valeur
	##
	## @return     self
	##
	def updateGrille(x, y, value)
		@content["grille"][x][y]["value"] = value

		return self
	end

	##
	## Sauvegarde la partie dans un fichier yaml
	##
	## @return     Self
	##
	def sauvegarder()
		@Jeu.chrono = Header.temps
		@Jeu.score = Header.score
		@Jeu.grille = @content["grille"]

		## Sauvegarde la partie dans un fichier yaml au nom de l'utilisateur
		@Jeu.creerPartie (@content["pseudo"])

		return self
	end

	##
	## Calcule les endroits possible pour une valeur
	##
	## @param      valeur  La valeur
	##
	## @return     self
	##
	def possibilites(valeur)
			
		possibilites = Array.new()

		## Calcule les coordonnées des cases qui permettent l'unicité sur la valeur
		## passée en paramètre
		for i in 0..8
			for j in 0..8
				if (@content["grille"][i][j]["editable"] && @Grille.valeurUnique(valeur, i, j) )
					possibilites << [i, j]
				end
			end
		end
		

		return possibilites
	end

	##
	## Réinitialise la grille
	##
	## @return     self
	##
	def reinitialiser()

		grille = @content["grille"]

		for i in 0..8
			for j in 0..8
				if(grille[i][j]["editable"])
					grille[i][j]["value"] = nil
				end
			end
		end

		@content["grille"] = grille
		return self
	end


	##
	## Calcule les candidats possibles pour chaque case
	##
	## @return     Hash de tableau avec coordonnées des possibilités 
	## 				pour chaque chiffre
	##
	def getCandidats

		candidats = Hash.new()

		for i in 1..9
			candidats[i.to_s] = self.possibilites(i)
		end

		return candidats
	end

	##
    ## Méthode à définir dans tout les cas !
    ##
    ## @return self
    ##
	def run()

		if(@content.has_key?("difficulte"))
			niveau = @content["difficulte"]
		else
			niveau = 1
		end

		@content["config"] = @Configuration.getConfiguration(@content["pseudo"])

		@Score.difficulte = niveau + 1
		@content["grille"] = @Grille.generer(niveau)

		return self
	end
end
