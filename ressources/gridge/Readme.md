---
title: Fonction gridge
author: Marc Thevenin (Ined)
---

<img src="g1.png" width=300 height=200>


# `gridge` [M.Thevenin]

## Installation

```{}
net install gridge, from("https://mthevenin.github.io/stata_graphiques/ressources/gridge/") replace
```

# Syntaxe

```{}
syntax variable [if], over(variable)  super(numeric 1.8) sort(string)  sortrev(string) bw(real>0 1.5) palette(string) colrev opac(integer 80) range(value1 value2) 
lc(integer 2)] lw(real .5)] gopts(string)]              
```
Entre parenthèse le type d'argument, suivi si nécessaire de la valeur par défaut. E

**Arguments**  

- `over(variable)`: variable de stratification. De type numérique avec ou non un label
- `super(numeric 1.8)`: degré de superposition des densités. Positif de préférence.
- `sort(string)`: **mean**, **median**, **sd**, **iqr**, **mode** (ou autre fonction statistique compatible avec `egen`)
- `sortrev(string)` - `sortr(string)`: idem mais les valeurs de la variable `over()` seront affichées en ordre décroissant
- `bw(real>0 1.5)`: largeur de la fenêtre de lissage.
- `palette(string)`  `pal(string)`: nom d'une palette du package `colorpalette`. Ce dernier sera installé comme dépendance si nécessaire. L'ordre des couleurs sera inversé par rapport à palette sélectionnée. 
- `colrev`: permet d'inverser l'ordre des couleurs de la palette. Perme de retrouve l'ordre de la palette d'origine de `colorpalette`
- `opac(integer 80)`: % d'opacité des couleurs. Valeur max = 100
- `range(value1 value2)`: permet de borner les valeurs de l'axe continue x. value1<value2
- `lc(integer 2)`: échelle de gris du contour des densités (palette **gs**). Valeurs comprise entre 1 (noir) et 15 (blanc)
- `lw(real .5)`: épaisseur du contour des densités en valeur relative. Valeur minimum 0
- `gopts(string)`: autres options des graphique de type `tw`: titre, xlabel, plotr, graphr.... Ne pas utiliser l option `ylabel` (option spécifique à venir).                                                                                       
                                                                                          
# Exemple

***Ouverture de la base***
```{}
webuse set  "https://raw.githubusercontent.com//mthevenin/stata_graphiques/master/ressources/gridge"
webuse "probability.dta", clear
webuse set
```
  
***Graphique***
```{}
#delimit ;
gridge p , over(proba) 
bw(2) range(0 100) super(0) 
palette(icefire) colrev  op(90)
gopts(title("Probabilités assignées", pos(11)) caption("Source: Reddit", size(*.5)) xtitle("probabilités (%)")) 
;
```

<img src="g1.png" width=641 height=466>

  



