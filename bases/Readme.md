
# Bases

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
     |------------------------------------------------------------------------------------------|
  6. |  Adelie   Torgersen       39.3       20.6        190       3650     male   2007   Adelie |
  7. |  Adelie   Torgersen       38.9       17.8        181       3625   female   2007   Adelie |
  8. |  Adelie   Torgersen       39.2       19.6        195       4675     male   2007   Adelie |
  9. |  Adelie   Torgersen       34.1       18.1        193       3475            2007   Adelie |
 10. |  Adelie   Torgersen         42       20.2        190       4250            2007   Adelie |
     +------------------------------------------------------------------------------------------+
```

Ouverture:
```{}
webuse set https://github.com/mthevenin/stata_graphiques/tree/main/bases
use pingouin, replace
webuse set
```
