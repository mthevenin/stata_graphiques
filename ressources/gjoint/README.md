
Petite commande graphique en version alpha: **`gjoint`**. Permet de visualiser la distribution croisée de deux variables quantitatives avec la commande **`hexplot`** de Ben Jann, en reportant également les distributions marginales avec des d'histogrammes.  
Pas de gros changement à prévoir, si ce n'est ajouter la possibilité de sélectionner des observations avec [if/else].  

<img src="g1.png" width=50%>


**Exemple**

***Installation**: pour l'instant manuellement. Récupérer le programme gjoint.ado à cette adresse: (<https://github.com/mthevenin/stata_graphiques/blob/main/ressources/gjoint/gjoint.ado>), l'exécuter dans l'éditeur de programme ou le sauvegarder dans un sous répertoire de l'ado plus

***Ouverture de la base***

```{}
webuse set  "https://raw.githubusercontent.com//mthevenin/stata_graphiques/master/ressources/gjoint"
webuse "logement.dta", clear
webuse set
```

***Exécution du graphique***

```{}
gjoint prix surface,  hopts(levels(10) fast) palette(flare, reverse) title("gjoint alpha")
```


*Remarque*: le temps d'exécution est de 6-7 secondes pour l'exemple (Stata 17 Se)



