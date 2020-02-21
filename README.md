# README
Bonjour à tous et bienvenue sur shaRespeare, l'application de partage de livre en ligne dans votre quartier.

I/ Pour voir la version en ligne du site, vous pouvez aller à l'adresse suivante : https://www.sharespeare.fr/

II/ Pour lancer le site localement:
  1. cloner le repo localement
  2. lancer la console dans le repo cloné
  3. executer rails db:create / rails db:migrate / rails db:seed
  4. executer rails s

III/ Attention:
La commande seed peut ne pas fonctionner.
Ceci est du à un blocage de sendgrid. Le service a été branché correctement car il fonctionne. Nous avons décidé de le payer pour 1 mois afin de pouvoir faire de nombreux tests. Malheuresement cela n'est pas suffidant et sendgrid impose un nombre d'envoie de mails par jour. En lançant le seed, cette limite peut être atteinte ce qui fera crasher le seed.

IV/ Conséquences:
  1. La navigation locale peut crasher lorqu'un mail doit être envoyer, notament à l'inscription.
  2. Idem pour la navigation en ligne, l'inscription peut ne pas fonctionner ainsi que toutes les interractions via mails entre   les utilisateurs.
  3. Nous espérons que le service sera actif lorsque le jury testera l'application.
  
V/ Remerciements
  Les 4 memebres de l'équipe, Arthur Wilbrod, Sacha Palayret, Philippe Diollot, Lucas Grandviergne tiennent à remercier
  notre mentor officiel : Frédéreic Bonnand mousaillon session 7
  notre mentor officieux : Léo  Robert mousaillon session 7
  l'équipe de THP pour la formation proposée
  l'équipe du projet Point of sales for suits and every business lines avec qui nous avons passé les 3 mois de la formation.
  
  Remerciements,
  L'équipe shaRespeare
