---
title: commande gjoint
author: Marc Thevenin (Ined-Sms)
---


<img src="g1.png" width=500 height=500>

**Commande `gjoint`**

- graphique combiné pour deux variables quantitatives
  - distributions marginales sous forme d'histogramme
  - distribution croisée avec la commande `hexplot` de **Ben Jann**
- Version très *alpha*

**Exemple**

***Installation***: pour l'instant manuellement. Récupérer le programme *gjoint.ado*, l'exécuter dans l'éditeur de programme ou le sauvegarder dans un sous répertoire de l'**ado plus** 

***Ouverture de la base***
```{}
webuse set  "https://raw.githubusercontent.com//mthevenin/stata_graphiques/master/ressources/gjoint"
webuse "logement.dta", clear
webuse set
```

***Exécution du graphique****
```{}
gjoint prix surface,  hopts(levels(10) fast) palette(flare, reverse) title("gjoint alpha")
```

*Remarque*: le temps d'exécution est de 6-7 secondes pour l'exemple (Stata 17 Se)


