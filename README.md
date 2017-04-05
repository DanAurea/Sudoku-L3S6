[![Build Status](https://travis-ci.org/DanAurea/Sudoku-L3S6.svg?branch=master)](https://travis-ci.org/DanAurea/Sudoku-L3S6) 
[![Issue Count](https://codeclimate.com/github/DanAurea/Sudoku-L3S6/badges/issue_count.svg)](https://codeclimate.com/github/DanAurea/Sudoku-L3S6)
[![Code Climate](https://codeclimate.com/github/DanAurea/Sudoku-L3S6/badges/gpa.svg)](https://codeclimate.com/github/DanAurea/Sudoku-L3S6)
[![Inline docs](http://inch-ci.org/github/DanAurea/Sudoku-L3S6.svg?branch=master)](http://inch-ci.org/github/DanAurea/Sudoku-L3S6)

# Introduction
## Présentation
Sudoku-L3S6 est un projet d'une application ayant pour but d'élaborer un assistant à la résolution d'un Sudoku, le projet s'inscrivant dans le module de Génie Logiciel dispensé à l'Université du Maine en fin de semestre de licence 3 de Sciences Pour l'Ingénieur.

Ce Sudoku représente notre application de l'ensemble des connaissances étudiées au cours de cette année. Cela va de la gestion de projet (répartition des rôles, rédaction de cahier des charges et de conception, gestion d'un dépôt Github) à sa modélisation (programmation orientée objet, gestion de base de données) et à son lancement.

Pour jouer, l'utilisateur se connecte via un nom profil qu'il insère au début de l'application. Puis selon ce qu'il souhaite jouer, il peut choisir le mode 'Apprentissage avec aides' ou bien 'Jeu Libre'. Le premier mode permet de mieux cerner le fonctionnement de chaque technique d'aide à la résolution du Sudoku avec des instructions pas à pas tandis que le deuxième mode fait jouer l'utilisateur selon un niveau de difficulté qu'il aura choisi avec des aides qui lui coûteront des points pour le score final. Ce score lui permettra d'ailleurs de se comparer aux autres joueurs pour pouvoir voir sa progression.
De plus, l'utilisateur peut tout à fait modifier la police ainsi que les couleurs liées aux cases, au texte ou aux indices dans les règlages. S'il ne connaît pas les règles, un rappel lui est donné dans la section appropriée dans le menu principal.

## Composition de l'équipe et rôle
Cette application a été réalisé par 8 étudiants de l'Université du Maine en utilisant comme langage de programmation Ruby associé à la bibliothèque Gtk. Chaque membre du groupe a un rôle afin d'organiser au mieux le projet :
* Bodineau Bastien [__Développeur & Testeur unitaires__] 
* Bussereau Keryann [__Développeur__]
* Cousin Brandon [__Architecte & Intégrateur__]
* Duran Alizée [__Documentaliste & Client-type__]
* Guenver Yann [__Développeur & Testeur intégration__]
* Jean Marvin [__Chef de projet__]
* Pavard Valentin [__Développeur GUI & Intégrateur__]
* Tabot Alexandre [__Développeur & Testeur intégration__]


# Installation
Pour satisfaire toutes les dépendances liées à cette application, installez simplement bundler puis installez le bundle associé:

> gem install bundler
>
> bundler install

Il est possible de générer une nouvelle gem et de l'installer à partir du Rakefile:

> rake install
