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
		loadModel("Utilisateur")

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
			
		## Mets à jours le compteur
		if(@content["grille"][x][y]["value"] == nil && value != nil)
			@Grille.nbVides -= 1
		elsif(@content["grille"][x][y]["value"] != nil && value == nil)
			@Grille.nbVides += 1
		end

		@content["grille"][x][y]["value"] = value

		return self
	end


	##
	## Vérifie que la grille est correcte
	##
	## @return     True si correcte sinon false
	##
	def grilleCorrecte()
		
		@content["grille"].each_with_index do | ligne, ligneIndex |
			ligne.each_with_index do | colonne, colonneIndex |
				if(!@Grille.valeurUnique(colonne["value"], ligneIndex, colonneIndex))
					return false
				end
			end
		end

		return true
	end

	##
	## Vérifie si la partie est terminée c'est à dire
	## grille complète et correcte.
	##
	## @return
	##
	def finPartie?()
		return self.getNbVides == 0  && self.grilleCorrecte()
	end

	##
	## Récupère le nombre de cases encore vides
	##
	## @return     Nombre de cases vides
	##
	def getNbVides()
		return @Grille.nbVides
	end

	##
	## Récupère seulement les valeurs de la grille
	##
	## @return     La grille que sous forme de valeur
	##
	def valeursGrille()
		grille = Array.new()

		@content["grille"].each_with_index do |ligne, index|
			grille << Array.new()
			ligne.each do |c|
				grille[index] << c["value"]
			end
		end

	end

	##
	## Action lorsque la partie est terminée,
	## sauvegarde du score de l'utilisateur.
	##
	## @return     self
	##
	def partieTerminee()
		Header.pause = true
		@Score.creer(@content["pseudo"], @Score.difficulte, Header.score)

		if(@Utilisateur.partieUtilisateur?(@content["pseudo"]))
			@Jeu.supprimerPartie(@content["pseudo"])
		end
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
		@Jeu.niveau = @Score.difficulte

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

		## Reprends la grille dans son état (singleton pattern) si on viens
		## d'une fenêtre par le biais d'un bouton retour 
		if(@Grille.grille != nil && !@content.has_key?("charger"))
			@content["grille"] = @Grille.grille

		## Reprends les configurations d'un fichier
		elsif(@content.has_key?("charger"))
			donnees = @Jeu.chargerPartie(@content["pseudo"])

			@content["difficulte"] = donnees["niveau"]
			Header.score           = donnees["score"]
			Header.temps           = donnees["chrono"]
			@content["grille"]     = donnees["grille"]
			@Grille.grille         = donnees["grille"]

		## Reggénère une grille
		else
			@content["grille"] = @Grille.generer(@content["difficulte"])
		end
		
		@content["config"] = @Configuration.getConfiguration(@content["pseudo"])
		
		if(@Score.difficulte == nil)
			@Score.difficulte = @content["difficulte"] + 1
		end

		@Grille.countNbVides

		return self
	end
end
