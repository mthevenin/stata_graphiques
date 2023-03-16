
Petite commande graphique en version alpha: **`gjoint`**. Permet de visualiser la distribution croisée de deux variables quantitatives avec la commande **`hexplot`** de Ben Jann, en reportant également les distributions marginales avec des d'histogrammes.  
Pas de gros changement à prévoir, si ce n'est ajouter la possibilité de sélectionner des observations.  


<img src="g1.png" width=50%>

**Exemple**

***Installation***:

```{r eval=FALSE}
net install gjoint, from("https://raw.githubusercontent.com/mthevenin/stata_graphiques/master/ressources/gjoint/") replace
```

***Ouverture de la base***

```{r eval=FALSE}
webuse set  "https://raw.githubusercontent.com//mthevenin/stata_graphiques/master/ressources/gjoint"
webuse "logement.dta", clear
webuse set
```

***Exécution du graphique***

```{r eval=FALSE}
gjoint prix surface,  hopts(levels(10) fast) palette(flare, reverse) title("gjoint alpha")
```


*Remarque*: le temps d'exécution est de 6-7 secondes pour l'exemple (Stata 17 Se)
