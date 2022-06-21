# `FABPLOT` [NJ.COX]

* Commande qui permet de contrôler les effets dits ***spaghetti*** (courbes) et ***paella*** (nuages de points)
* J'ai fait une petite modification au .ado d'origine en ajoutant une option qui permet de modifier les courbes ou le nuage de point en arrière plan. 
  La commande s'appelle **`fabplot2`**.
* Article du Stata journal de NJ.Cox: https://journals.sagepub.com/doi/full/10.1177/1536867X211025838
* J'avais présenté le problème lors de la formation de 2020, mais avec un programme très compliqué. Cette commande très simple, permet de bien contrôler ce problème visualisation  en utilisant sur deux objets graphiques l'option `by`.....pourquoi je n'y avais pas pensé.

# Installation

## `fabplot`

Commande d'origine. L'objet en arrière plan n'est pas modifiable.

```{}
ssc install fabplot
```

## `fabplot2`

J'ai juste ajouté l'option **`backopts`**. Même principe que l'option **`frontopts`** qui modifie l'objet au premier plan.

```{}
net install fabplot2, from("https://mthevenin.github.io/stata_graphiques/ressources/fabplot/") replace
```

## Exemple


> **Note** J'utilise systématiquement un thème  que je génère avec le paquet **`grstyle`** de B.Jann.  


Je reprends le même exemple que pour la formation, avec la base babynames.  
Ouverture de de la base:  
```{}
webuse set https://github.com/mthevenin/stata_graphiques/tree/main/ressources/fabplot
use babynames, replace
webuse set
```
### Empilement des 9 courbes

..... C'est illisible

```{}
* thème avec grstyle
grstyle init 
grstyle set mesh
grstyle set color tableau, n(9)

* Graphique
levelsof name, local(name)
local i = 1
foreach nom of local name  {
local j = `i++'	
local line `line' line n year if name=="`nom'" ||		
local leg `leg'  `j' "`nom'"
}

tw `line' , legend(order(`leg') row(2) size(*.8)  region(color(%0)) pos(11)) ytitle("") ylabel(0(20000)100000, angle(0)) ///
title("Popularité des prénoms")
```





