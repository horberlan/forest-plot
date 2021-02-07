# Forest Plot — Meta-Analysis with Subgroups using R


[![Meta Rstudio](https://img.shields.io/endpoint?url=https%3A%2F%2Frstudio.github.io%2Frstudio-shields%2Fcategory%2Fmeta.json)](https://community.rstudio.com/c/meta)
<h2 align="center"> Forest Plot - performing Meta-analysis in subgroups. Using the <a href="https://cran.r-project.org/web/packages/meta/index.html">Meta</a> package in the R programming language.</h2>

# 1. Analysis 

## 1.2 Get and load data

```R
# https://www.rdocumentation.org/packages/grid/versions/3.6.2
# https://cran.r-project.org/web/packages/readxl/index.html
# https://cran.r-project.org/web/packages/meta/index.html

library(readxl)
library(grid)
library(meta)
```


## 1.3 Tables

```R
# Importe table 
dat <- read_xlsx("LP.xlsx")
dat
```


```R
# A tibble: 16 x 8
#   study    Measure    nd meand   sdd     n  mean    sd
#   <chr>    <chr>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
# 1 Study 1  CT          6 129.4  5.14     6 145.  11.2 
# 2 Study 2  CT          6  98.4  3.28     6 135.   1.96
# 3 Study 3  CT         10  54.3  2.8     10  56.1  2.6 
# 4 Study 4  CT          6  90.5  1.87     6 130.   3.02
# 5 Study 5  CT          8  72.7  7.4      8 103    5.5 
# 6 Study 6  CT          6  90.3  2.72     6 107.   3.09
# 7 Study 7  CT          6  92.3  2.71     6 106.   3.05
# 8 Study 8  TG          6 128.   6.93     6 269.  13.6 
# 9 Study 9  TG          6 110.   2.48     6  25.7  1.16
#10 Study 10 TG         10  60.6  7.5     10  85.5 13.3 
#11 Study 11 TG          6  93.3  1.51     6 153    3.35
#12 Study 12 TG          6  88.5  3.23     6 105.   2.8 
#13 Study 13 TG          6  88.5  3.23     6  75.4  3.15
#14 Study 14 HDL         6  34.6  2.39     6  22.7  2.58
#15 Study 15 HDL         6  42.5  2.98     6  25.7  1.16
#16 Study 16 HDL         6  31.4  0.82     6  25.2  0.98
```
```R
dat.frame_2 <- data.frame(dat)
```
<center>

| study    | Measure | nd | meand  | sdd  | n  | mean   | sd    | 
|:--------:|:-------:|:--:|:------:|:----:|:--:|:------:|:-----:|
| Study 1  | CT      | 6  | 129,46 | 5,14 | 6  | 144,79 | 11,25 |
| Study 2  | CT      | 6  | 98,42  | 3,28 | 6  | 134,83 | 1,96  |
| Study 3  | CT      | 10 | 54,3   | 2,8  | 10 | 56,1   | 2,6   |
| Study 4  | CT      | 6  | 90,5   | 1,87 | 6  | 130,5  | 3,02  |
| Study 5  | CT      | 8  | 72,7   | 7,4  | 8  | 103    | 5,5   |
| Study 6  | CT      | 6  | 90,3   | 2,72 | 6  | 106,8  | 3,09  |
| Study 7  | CT      | 6  | 92,3   | 2,71 | 6  | 106,5  | 3,05  |
| Study 8  | TG      | 6  | 127,82 | 6,93 | 6  | 269,3  | 13,59 |
| Study 9  | TG      | 6  | 110,22 | 2,48 | 6  | 25,67  | 1,16  |
| Study 10 | TG      | 10 | 60,6   | 7,5  | 10 | 85,5   | 13,3  |
| Study 11 | TG      | 6  | 93,33  | 1,51 | 6  | 153    | 3,35  |
| Study 12 | TG      | 6  | 88,5   | 3,23 | 6  | 105,1  | 2,8   |
| Study 13 | TG      | 6  | 88,5   | 3,23 | 6  | 75,41  | 3,15  |
| Study 14 | HDL     | 6  | 34,64  | 2,39 | 6  | 22,69  | 2,58  |
| Study 15 | HDL     | 6  | 42,46  | 2,98 | 6  | 25,67  | 1,16  |
| Study 16 | HDL     | 6  | 31,37  | 0,82 | 6  | 25,16  | 0,98  |


</center>



```R

meta_2 <- metacont(dat$n,
                    dat$meand,
                    dat$sdd,
                    dat$nd,
                    dat$mean,
                    dat$sd,
                    dat$study,
                    data = dat.frame_2,
                    byvar = Measure,
                    comb.fixed = TRUE,
                    sm="SMD"
                    )
```
```R
> meta_2                    
              SMD               95%-CI %W(fixed) %W(random) Measure
Study 1   -1.6180 [ -2.9980;  -0.2380]      13.8        7.9      CT
Study 2  -12.4393 [-18.6163;  -6.2624]       0.7        4.9      CT
Study 3   -0.6381 [ -1.5419;   0.2658]      32.2        8.1      CT
Study 4  -14.7004 [-21.9653;  -7.4355]       0.5        4.2      CT
Study 5   -4.3940 [ -6.4029;  -2.3852]       6.5        7.7      CT
Study 6   -5.2324 [ -8.0260;  -2.4387]       3.4        7.2      CT
Study 7   -4.5434 [ -7.0333;  -2.0535]       4.2        7.4      CT
Study 8  -12.1070 [-18.1246;  -6.0895]       0.7        5.0      TG
Study 9   40.3136 [ 20.6015;  60.0258]       0.1        1.0      TG
Study 10  -2.2088 [ -3.3715;  -1.0461]      19.5        8.0      TG
Study 11 -21.1983 [-31.6082; -10.7884]       0.2        2.8      TG
Study 12  -5.0694 [ -7.7906;  -2.3483]       3.6        7.3      TG
Study 13   3.7875 [  1.6198;   5.9552]       5.6        7.6      TG
Study 14   4.4357 [  1.9925;   6.8789]       4.4        7.4     HDL
Study 15   6.8541 [  3.3220;  10.3862]       2.1        6.7     HDL
Study 16   6.3442 [  3.0469;   9.6415]       2.4        6.9     HDL

Number of studies combined: k = 16

                         SMD             95%-CI     z  p-value
Fixed effect model   -1.2611 [-1.7742; -0.7480] -4.82 < 0.0001
Random effects model -2.2628 [-4.3930; -0.1327] -2.08   0.0373

Quantifying heterogeneity:
 tau^2 = 14.3627 [20.6661; 124.3353]; tau = 3.7898 [4.5460; 11.1506]
 I^2 = 92.0% [88.6%; 94.4%]; H = 3.54 [2.96; 4.22]

Test of heterogeneity:
      Q d.f.  p-value
 187.76   15 < 0.0001


 Results for subgroups (fixed effect model):
       k     SMD             95%-CI     Q   I^2
 CT    7 -2.0276 [-2.6825; -1.3727] 46.33 87.0%
 TG    6 -1.7203 [-2.6622; -0.7783] 73.66 93.2%
 HDL   3  5.5232 [ 3.8074;  7.2391]  1.54  0.0%


 Results for subgroups (random effects model):
       k     SMD             95%-CI   tau^2    tau
 CT    7 -4.6427 [-6.9204; -2.3651]  6.8810 2.6232
 TG    6 -3.2292 [-8.3922;  1.9338] 30.5857 5.5304
 HDL   3  5.5232 [ 3.8074;  7.2391]       0      0


```


# 2. PLots
Plot forest and read the comments in the code about the functions used.

```R
#RE.res <- rma(n,meand,sdd,mean,sd, data=dat.frame_2, slab=paste(Measure))
#RE.res
png(file = 'LP - Forestplot.png', # Save plot as PNG
    width=780,
    height=620)

forest(meta_2,
      order=order(dat$study), # Where you should initially order the data. 
      leftlabs = c("Lipid Profile 
      Author", "Total","Mean","SD","Total","Mean","SD"),
      comb.random=FALSE, # Do not plot the random effect. 
      xlim = c(-70,70), 
      xlab="Standarized Mean Difference (95% CI)",
      mlab="RE Model for All Studies",
      subgroup = TRUE,
      print.byvar = FALSE, # Don't print meta_2$$Measure.
      )
dev.off()
```
<p align="center">
<img align="center" src="https://raw.githubusercontent.com/horberlan/forest-plot/main/LP%20-%20Forestplot.png">
</p>
<br>

# 3. References

  
1.  R Core Team. (2017). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. Retrieved from https://www.R-project.org/

2.  Veroniki AA, Jackson D, Viechtbauer W, Bender R, Bowden J, Knapp G, et al. (2016): Methods to estimate the between-study variance and its uncertainty in meta-analysis. Research Synthesis Methods, 7, 55–79 
