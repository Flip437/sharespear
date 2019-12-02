# README




# GITHUB
NE JAMAIS CODER SUR MASTER NE JAMAIS PUSH SUR MASTER

$ git checkout master : pour s’assurer qu’on est bien sur la branche master sur son ordi.


$ git pull origin master : pour récupérer de GitHub la dernière version de master.


$ git branch nom_de_ta_feature : pour créer une branche nommée  “nom_de_ta_feature” à partir de master qui est désormais à jour.


$ git checkout nom_de_ta_feature : pour se positionner sur la branche “nom_de_ta_feature”.

$ git add nom_page pour préparer à commit les fichiers ayant été modifiés

$ git commit -m “commentaire sur mon commit” pour faire un commit

$git push origin nom_de_branche

AVANT DE PUSH SUR TA BRANHCE POUR FAIRE UN MASTER

Fusionner la branche contenant ton travail avec le dernier master en local

$ git checkout master
$ git pull origin master
$ git checkout nom_de_ta_feature
$ git merge master
$ git push origin nom_de_branche


Depuis le site github merge sur github
