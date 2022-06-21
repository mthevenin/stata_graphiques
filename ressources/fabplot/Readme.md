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

J'ai juste ajouté l'option **`backopts`**. Même principe que l'option **`frontopts`** qui modifie l'objet au premier plan

```{}
net install fabplot2, from("https://mthevenin.github.io/stata_graphiques/ressources/fabplot/") replace
```

## Exemple
