#!/bin/bash
#****************************************
# * Projet : galerie.sh
# * Description : cree un generateur de galerie d'image en bash
# *
# * Date : 30.10.2020(debut)
# * Version : 2.0.0
# * Auteur : Gregoire Pean
# ****************************************/
    
IFS=$'\n' #definis les separateur de tableau sur le retour de ligne
rm galerie.html #suprime le site si il exite deja
rm css.css #suprime le css du site si il exite deja
rm -rf Miniature #suprime les miniatures si il en a deja
mkdir Miniature #cre le dossier miniature
LISTEMINIATURES=("$(ls *.{jpg,gif,png,jpeg,PNG})") #cree une liste contenant les nom des futurs miniatures
IMAGESDANSLESITE="" #initialise la variable qui vas contenir les miniature du site
ELEMENT="" #initialise la variable qui vas contenir les element de LISTEMINIATURES
TAILLEMINI="300x300";
REPONSE="";
COMPTEUR=0;

echo "
body {

    text-align: center;
    background-color: rgb(230, 220, 220);
    font-family: Jazz LET, fantasy;
}

img {

    margin: 10px;
}

" > css.css # css permetant de donne un aspect claire au site

for ELEMENT in $LISTEMINIATURES 
do
	((COMPTEUR=$COMPTEUR+1))
done

if test $COMPTEUR -lt 1
then
clear
echo "Vous devez avoir des image pour cree la galerie"
exit 1

fi


	while :; do
		
		clear
		echo 
		echo "-------------------------------------------------------------"
		echo -e "\033[31mBienvenue, ici vous pouvez personnalise votre galerie."
		echo "La taille des miniatures par defaut est 300x300 et le"
		echo -e "thème est claire. \033[0m"
		echo "--------------------------------------------------------------"
		echo " 1 - Choisir la taille"
		echo " 2 - Choisir le theme"
		echo " 3 - Suprimer des images de la galerie"
		echo " C - Crée le site"
		echo
	
		shopt -s -o nounset # Force lutilisateur a mettre une reponse valide
		$* 
	
		read -p 'Saisir la commande souhaitée : ' REPONSE	# Lecture du choix de l'utilisateur
	
		case $REPONSE in
			1) 
		while :; do
			clear
	
			echo
			echo "--------------------------------------"
			echo -e "\033[31mTaille disponilbe\033[0m"
			echo "--------------------------------------"
			echo " 1 - 200x200"
			echo " 2 - 300x300"
			echo " 3 - 400x400"
			echo " 4 - 500x500"
			echo " Q - Quitter"
			echo
	
			shopt -s -o nounset # Force lutilisateur a mettre une reponse valide
			$* 
	
			read -p 'Saisir la commande souhaitée : ' REPONSE	# Lecture du choix de l'utilisateur
	
			case $REPONSE in
				1) TAILLEMINI="200x200" 
                break;;
				2) TAILLEMINI="300x300" 
                break;;
				3) TAILLEMINI="400x400" 
                break;;
				4) TAILLEMINI="500x500" 
                break;;
				q | Q) break;;
			esac 	
		done 
	;;
	
			2)
			
			while :; do
	clear

	echo
	echo "--------------------------------------"
	echo -e "\033[31mChoisiser le thème de votre galerie :\033[0m"
    echo "--------------------------------------"
    echo " 1 - Thème rgb"
	echo " 2 - Thème sombre"
	echo " 3 - Thème claire"
	echo " Q - Quitter"
	echo
	echo
    #creation dun menu a 3 choix pour choisir le theme de la galerie
	shopt -s -o nounset # Force lutilisateur a mettre une reponse valide
	$* 

	read -p 'Saisir la commande souhaitée : ' REPONSE	# Lecture du choix de l'utilisateur

	case $REPONSE in
		1) 
            echo "
body {
	background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
	background-size: 5000% 1000%;
    animation: gradient 15s ease infinite;
    font-family: Blippo, fantasy;
    text-align: center;
}

@keyframes gradient {
	0% {
		background-position: 0% 50%;
	}
	50% {
		background-position: 100% 50%;
	}
	100% {
		background-position: 0% 50%;
	}
}

img {

    margin: 10px;
}

" > css.css # css permetant de donne un aspect rgb au site
break;;

		2) 
    echo "
body {

    text-align: center;
    background-color: rgb(61, 58, 58);
    font-family: Jazz LET, fantasy;
    color: blanchedalmond;
}

img {

    margin: 10px;
}

" > css.css # css permetant de donne un aspect sombre au sitee
break;;


		3)
    echo "
body {

    text-align: center;
    background-color: rgb(230, 220, 220);
    font-family: Jazz LET, fantasy;
}

img {

    margin: 10px;
}

" > css.css # css permetant de donne un aspect claire au site
break;;

				q | Q) break;;

	esac 
done
			
			;;
			3) 

			while :; do
			clear
			
			echo
			echo "----------------------------------------------------"
			echo -e "\033[31mPour les suprimer selectionner leur numéro\033[0m"
			echo "----------------------------------------------------"
			COMPTEUR=0
			for ELEMENT in $LISTEMINIATURES 
			do
				((COMPTEUR=$COMPTEUR+1))
				echo " $COMPTEUR - $ELEMENT"
			done
			((COMPTEUR=1))
			echo " Q - Quitter"
			echo
	
			shopt -s -o nounset # Force lutilisateur a mettre une reponse valide
			$* 

			
	
			read -p 'Saisir la commande souhaitée : ' REPONSE	# Lecture du choix de l'utilisateur

			case $REPONSE in
				q | Q) break;;
				*)

					array=$LISTEMINIATURES
    				rm ${array[($REPONSE-1))]}
				;;
			esac 
			LISTEMINIATURES=("$(ls *.{jpg,gif,png,jpeg,PNG})")	# Actualisation de la list dimage apres qu'on en ais suprimer
		done 
	;;
		
			c | C) break;;
		esac 
	done 
	
for ELEMENT in $LISTEMINIATURES
do
    convert $ELEMENT -thumbnail "$TAILLEMINI" Miniature/$ELEMENT
    IMAGESDANSLESITE+="
    <a href=\"$ELEMENT\"><img src=\"Miniature/$ELEMENT\"/></a>
    "
done
#cette boucle redimensionne et copie chaque image dans miniature puis les insert dans une balise html


echo "
<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Document</title>
    <link rel=\"stylesheet\" href=\"css.css\">
</head>
<body>

    <h1>Votre galerie</h1> 

$IMAGESDANSLESITE

</body>
</html>
" > galerie.html #il cree le site avec les miniature et insert le code dans galerie.html

clear #efface les commande qui on ete faite

