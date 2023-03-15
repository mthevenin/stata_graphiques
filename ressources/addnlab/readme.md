
Une petite commande sans trop de prétention.  

* Permet d'ajouter sur l'axe discret d'un graphique, le nombre d'observations de chaque modalité
* On peut également l'utiliser, avec une manipulation supplémentaire, pour les modèles

**Installation**  

`net install addnlab, from("https://raw.githubusercontent.com/mthevenin/stata_graphiques/master/ressources/addnlab/") replace`


**Syntaxe**  

`addnlab varlist  [if/in] , [back]`

* On ne peut pas exécuter deux fois de suite si au moins une variable dans la liste à déjà les effectifs affecter au label. 
* On revient au label d'origine en ajoutant l'option **`back`**

**Exemple Graphique**  

```{}
sysuse nlsw88, clear
recode occupation (9 10 11 12 = 13 )

addnlab  occupation 
gridge wage, over(occupation) sortrev(mean) range(0 50) palette(flare) bw(.5)
addnlab  occupation, back
```

<img src="g1.png" width=50%>


**Exemple Régression**  

La manipulation supplémentaire est particulièrement simple: On exécute le modèle une première pour récupérer **`e(sample)`**. Puis on l'affect à `addnlab` comme expression de sélection des observationss.  


```{}
sysuse nlsw88, clear

recode occupation (9 10 11 12 = 13 )

regress wage  i.occupation i.south i.race ttl_exp  if married==1
```

```{}
-----------------------------------------------------------------------------------------
                   wage | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
------------------------+----------------------------------------------------------------
             occupation |
Professional/Technical  |      0.000  (base)
        Managers/Admin  |     -0.002      0.525    -0.00   0.997       -1.032       1.028
                 Sales  |     -2.969      0.415    -7.16   0.000       -3.783      -2.156
    Clerical/Unskilled  |     -1.413      0.710    -1.99   0.047       -2.805      -0.021
             Craftsmen  |     -2.451      0.935    -2.62   0.009       -4.286      -0.617
            Operatives  |     -3.939      0.560    -7.03   0.000       -5.038      -2.840
             Transport  |     -4.862      1.443    -3.37   0.001       -7.691      -2.032
              Laborers  |     -4.346      0.531    -8.19   0.000       -5.387      -3.305
                 Other  |     -1.650      0.525    -3.14   0.002       -2.681      -0.620
                        |
                  south |
             Not south  |      0.000  (base)
                 South  |     -1.140      0.275    -4.15   0.000       -1.679      -0.602
                        |
                   race |
                 White  |      0.000  (base)
                 Black  |      0.057      0.352     0.16   0.872       -0.634       0.748
                 Other  |      0.728      1.183     0.62   0.539       -1.592       3.048
                        |
                ttl_exp |      0.256      0.030     8.51   0.000        0.197       0.315
                  _cons |      7.161      0.549    13.03   0.000        6.083       8.239
-----------------------------------------------------------------------------------------
```

```{}
addnlab married occupation south race if e(sample)

regress wage  i.occupation i.south i.race ttl_exp if married==1

addnlab married occupation south race, back  // ne pas oublier
```

```{}

-----------------------------------------------------------------------------------------------
                         wage | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
------------------------------+----------------------------------------------------------------
                   occupation |
Professional/Technical (204)  |      0.000  (base)
        Managers/Admin (158)  |     -0.004      0.525    -0.01   0.994       -1.035       1.026
                 Sales (499)  |     -2.979      0.415    -7.18   0.000       -3.793      -2.165
     Clerical/Unskilled (66)  |     -1.429      0.710    -2.01   0.044       -2.821      -0.036
              Craftsmen (33)  |     -2.469      0.936    -2.64   0.008       -4.305      -0.634
            Operatives (136)  |     -3.961      0.561    -7.07   0.000       -5.060      -2.861
              Transport (13)  |     -4.916      1.444    -3.41   0.001       -7.748      -2.084
              Laborers (167)  |     -4.370      0.531    -8.23   0.000       -5.412      -3.328
                 Farmers (1)  |     -2.788      4.971    -0.56   0.575      -12.540       6.964
           Farm laborers (5)  |     -4.642      2.260    -2.05   0.040       -9.076      -0.209
                Service (10)  |     -2.949      1.616    -1.82   0.068       -6.118       0.221
       Household workers (1)  |     -2.345      4.971    -0.47   0.637      -12.095       7.406
                 Other (145)  |     -1.459      0.541    -2.70   0.007       -2.520      -0.399
                              |
                        south |
             Not south (838)  |      0.000  (base)
                 South (600)  |     -1.115      0.275    -4.05   0.000       -1.655      -0.574
                              |
                         race |
                White (1147)  |      0.000  (base)
                 Black (273)  |      0.085      0.353     0.24   0.809       -0.607       0.778
                  Other (18)  |      0.743      1.183     0.63   0.530       -1.578       3.064
                              |
                      ttl_exp |      0.251      0.030     8.29   0.000        0.191       0.310
                        _cons |      7.216      0.551    13.09   0.000        6.135       8.297
-----------------------------------------------------------------------------------------------

```







