library(readxl)
library(metafor)
library(grid)
library(meta)
dat <- read_xlsx("BP.xlsx")

dat.frame <- data.frame(dat
                        )
#dat.frame
meta_1 <- metacont(dat$n,
                   dat$meand,
                   dat$sdd,
                   dat$nd,
                   dat$mean,
                   dat$sd,
                   dat$study,
                   data = dat.frame,
                   byvar = Measure,
                   comb.fixed = TRUE,
                   sm="SMD"
                   )

png(file = 'BP - Forestplot.png',
    width=1000,
    height=975)

forest(meta_1,
       order=order(dat$study),
       leftlabs = c("Biochemical Parameters
                    Author", "Total","Mean","SD","Total","Mean","SD"),
       comb.random=FALSE,
       rows=c(1:3, 4:8, 8:10, 11:15, 16:19, 20:23),
       xlim = c(-10,10),
       xlab="Standarized Mean Difference (95% CI)",
       mlab="RE Model for All Studies",
       subgroup = TRUE,
       print.byvar = FALSE,
)
dev.off()