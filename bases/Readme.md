
# Liste Bases

* rbnb_paris
* pingouin


# Descriptif bases

## rbnb_paris.dta

```{
Contains data from rbnb_paris.dta
 Observations:        56,914                  
    Variables:             3                  11 Jul 2022 12:46
-------------------------------------------------------------------
Variable      Storage   Display    Value
    name         type    format    label      Variable label
-------------------------------------------------------------------
zone            long    %19.0g     zone       
type            float   %15.0g     type       
-------------------------------------------------------------------
```

```{}
     +------------------------------------------+
     | price                  zone         type |
     |------------------------------------------|
  1. |     .                     .       autres |
  2. |    59       Buttes-Chaumont   apt/maison |
  3. |    30               Reuilly   apt/maison |
  4. |    53          Ménilmontant   apt/maison |
  5. |   500   Batignolles-Monceau   apt/maison |
     +------------------------------------------+
```

Ouverture:
```{}
webuse set https://github.com/mthevenin/stata_graphiques/tree/main/bases
use rbnb_paris, replace
webuse set
```

## pingouins.dta

```{}
------------------------------------------------------------------------------------------
Variable      Storage   Display    Value
    name         type    format    label      Variable label
------------------------------------------------------------------------------------------
species         str9    %9s                   species
island          str9    %9s                   island
bill_length_mm  double  %10.0g                bill_length_mm
bill_depth_mm   double  %10.0g                bill_depth_mm
flipper_lengt~m int     %10.0g                flipper_length_mm
body_mass_g     int     %10.0g                body_mass_g
sex             str6    %9s                   sex
year            int     %10.0g                year
espèce          long    %9.0g      espèce     species
------------------------------------------------------------------------------------------
```

```{}

     +------------------------------------------------------------------------------------------+
     | species      island   bill_l~m   bill_d~m   flippe~m   body_m~g      sex   year   espèce |
     |------------------------------------------------------------------------------------------|
  1. |  Adelie   Torgersen       39.1       18.7        181       3750     male   2007   Adelie |
  2. |  Adelie   Torgersen       39.5       17.4        186       3800   female   2007   Adelie |
  3. |  Adelie   Torgersen       40.3         18        195       3250   female   2007   Adelie |
  4. |  Adelie   Torgersen          .          .          .          .            2007   Adelie |
  5. |  Adelie   Torgersen       36.7       19.3        193       3450   female   2007   Adelie |
     +------------------------------------------------------------------------------------------+
```

Ouverture:
```{}
webuse set https://github.com/mthevenin/stata_graphiques/tree/main/bases
use pingouin, replace
webuse set
```
