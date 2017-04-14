
# 	Author:: 		DanAurea
# 	Version:: 		0.1
# 	Copyright:: 	© 2016
# 	License::   	Distributes under the same terms as Ruby
# 	
 
##
## Déclaration de la table contenant les paramètres 
## Modèle de configuration
## 
class Configuration < Model
	
	#Définit la couleur de la case de base
	CL_CASE_BASE        = "65535, 65535, 65535"
	#Définit la couleur de la case fixe
	CL_CASE_FIXE        = "55000, 55000, 55000"
	#Définit la couleur de la case sélectionnée
	CL_CASE_SELECTIONNE = "64764, 59881, 20303"
	#Définit la couleur des indices
	CL_INDICES          = "0, 32000, 65535"
	#Définit la couleur du texte
	CL_TEXTE			= "0, 0, 0"
	#Définit la police du texte
	POLICE              = "Sans Regular"
	#Définit la taille de la police
	TAILLE_POLICE		= 25

	##
	## Initialisation
	##
	def initialize()
		
		## Crée la table configuration
		@@db.execute  "CREATE TABLE IF NOT EXISTS configuration (
						config_id integer primary key autoincrement,
						caseBase varchar(30) DEFAULT '#{CL_CASE_BASE}',
						caseFixe varchar(30) DEFAULT '#{CL_CASE_FIXE}',
						caseSelectionne varchar(30) DEFAULT '#{CL_CASE_SELECTIONNE}',
						couleurTexte varchar(30) DEFAULT '#{CL_TEXTE}',
						couleurIndices varchar(30) DEFAULT '#{CL_INDICES}',
						police varchar(50) DEFAULT 'Sans Regular',
						taillePolice integer DEFAULT #{TAILLE_POLICE},
						utilisateur integer,
						FOREIGN KEY(utilisateur) REFERENCES utilisateur(utilisateur_id)
						);"
	end


	##
	## Enregistre la configuration dans la base de donnée. 
	##
	## @param 	config 		La Configuration   
	##
	def enregistrer(pseudo, config)
		utilisateur_id =  @@db.execute "SELECT utilisateur_id FROM utilisateur WHERE pseudo=?", pseudo
		
		req = @@db.execute "SELECT * FROM configuration WHERE utilisateur=?", utilisateur_id
			
		params = Hash.new()

		## Définit tout les paramètres à enregistrer à partir de la configuration
		config.each do |key, param|
			params[key.to_sym] = param
		end

		## Définit l'identifiant de l'utilisateur
		params[:utilisateur]     = utilisateur_id[0][0]

		if(req.length > 0)
			@@db.execute "DELETE FROM configuration WHERE utilisateur = ?", utilisateur_id[0][0]
		end
		
		insert(params)
	end

	##
	## Récupère la configuration de l'utilisateur
	##
	## @param      pseudo  Pseudo utilisateur
	##
	## @return     Configuration sous forme de tableau
	##
	def getConfiguration(pseudo)
		utilisateur_id =  @@db.execute "SELECT utilisateur_id FROM utilisateur WHERE pseudo=?", pseudo

		req = @@db.execute2 "SELECT caseBase, caseFixe, caseSelectionne, couleurTexte, couleurIndices, taillePolice, police FROM configuration WHERE utilisateur=?", utilisateur_id

		## Pas de configuration trouvé donc on en
		## crée une
		if(req .length== 1)
			self.creerConfiguration(pseudo)
			req = @@db.execute2 "SELECT caseBase, caseFixe, caseSelectionne, couleurTexte, couleurIndices, taillePolice, police FROM configuration WHERE utilisateur=?", utilisateur_id
		end

		return self.to_h(req)[0]
	end
	
	##
    ## Limite le dépassement de valeur d'une couleur 16 bits
    ##
    ## @param      couleur  La couleur à vérifier
    ##
    ## @return     La couleur limitée à la borne si dépassement sinon la couleur elle même
    ##
    def verifierCouleur(couleur)
        max = 65535
        min = 0

        if(couleur >  max)
            couleur = max
        elsif(couleur < 0)
            couleur = min
        end

        return couleur
    end

	##
    ## Convertis un gdk color en composantes
    ##              sous forme d'une chaîne séparée par une virgule
    ##
    ## @param      gdkColor GDK::Color
    ##
    ## @return     Les composantes sous forme de chaîne
    ##
    def couleur(gdkColor)
        red = gdkColor.red
        green = gdkColor.green
        blue = gdkColor.blue

        return "#{red},#{green},#{blue}"
    end

	##
    ## Crée un gdk color à partir d'une chaîne
    ##
    ## @param      composantes  Composantes ("r,g,b")
    ##
    ## @return     Gdk::Color
    ##
    def creerCouleur(composantes)
    	rgb = composantes.split(",")
    	
    	red = self.verifierCouleur(rgb[0].to_i)
    	green = self.verifierCouleur(rgb[1].to_i)
    	blue = self.verifierCouleur(rgb[2].to_i)

    	return Gdk::Color.new(red, green, blue)
    end

	##
	## Crée une configuration par défaut pour l'utilisateur
	##
	## @param      utilisateurId  L'identifiant utilisateur
	##
	## @return     self
	##
	def creerConfiguration(pseudo)

		## Récupère id utilisateur
		req = @@db.execute "SELECT utilisateur_id FROM utilisateur WHERE pseudo = ?", pseudo

		params = Hash.new()

		params[:caseBase] = Configuration::CL_CASE_BASE
		params[:caseFixe] = Configuration::CL_CASE_FIXE
		params[:caseSelectionne] = Configuration::CL_CASE_SELECTIONNE
		params[:couleurTexte] = Configuration::CL_TEXTE
		params[:couleurIndices] = Configuration::CL_INDICES
		params[:police] = Configuration::POLICE
		params[:taillePolice] = Configuration::TAILLE_POLICE
		params[:utilisateur] = req[0]

		insert(params)
		
		return self
	end

end