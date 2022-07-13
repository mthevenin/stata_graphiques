---
title: Fonction gridge
author: Marc Thevenin (Ined)
---

<img src="g1.png" width=300 height=200>

**EN COURS**

# `gridge` [M.Thevenin]

## Installation

```{}
net install gridge, from("https://mthevenin.github.io/stata_graphiques/ressources/gridge/") replace
```

# Syntaxe

```{}
syntax variable [if], over(variable)  super(numeric 1.8) sort(string)  sortrev(string) bw(real 1.5) paLette(string) colrev opac(integer 80) range(value1 value2) 
lc(integer 2)] lw(numeric .5)] gopts(string)]              
```
Entre parenthèse le type d'argument, suivi si nécessaire de la valeur par défaut. E

**Arguments**  

- `over(variable)`: variable de stratification. De type numérique avec ou non un label
- `super(numeric 1.8)`: degré de superposition des densités. Positif de préférence.
- `sort(string)`: **mean**, **median**, **sd**, **iqr**, **mode** (ou autre fonction statistique compatible avec `egen`)
- `sortrev(string)` `sortr(string)`: idem mais les valeurs de la variable `over()` seront affichées en ordre décroissant
- 



<ul>ffffffff</ul>







