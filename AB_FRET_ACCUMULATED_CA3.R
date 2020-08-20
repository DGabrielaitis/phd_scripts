# 20 08 2020

# AB FRET analysis, while accumulating all of the FI's

setwd("/Volumes/NO NAME/conf/SynFRET_data/AB-FRET/DATA_automated")
rm(list = ls())
library(readr)
library(ggplot2)
library(ggsignif)
library(boot)
library(ggpubr)
library(dplyr)


# import the data
PRE_1 <- read_csv("pre1.csv")
POST_1 <- read_csv("post1.csv")
PRE_1$type<-'PRE'
POST_1$type<-'POST'
PRE_2 <- read_csv("pre2.csv")
POST_2 <- read_csv("post2.csv")
PRE_2$type<-'PRE'
POST_2$type<-'POST'
PRE_3 <- read_csv("pre3.csv")
POST_3 <- read_csv("post3.csv")
PRE_3$type<-'PRE'
POST_3$type<-'POST'
PRE_4 <- read_csv("pre4.csv")
POST_4 <- read_csv("post4.csv")
PRE_4$type<-'PRE'
POST_4$type<-'POST'
#filter data
PRE_1 <- filter(PRE_3, PRE_3$Area>0.05)
POST_1 <- filter(POST_3, POST_3$Area>0.05)
PRE_1 <- filter(PRE_3, PRE_3$Area<2)
POST_1 <- filter(POST_3, POST_3$Area<2)
PRE_2 <- filter(PRE_3, PRE_3$Area>0.05)
POST_2 <- filter(POST_3, POST_3$Area>0.05)
PRE_2 <- filter(PRE_3, PRE_3$Area<2)
POST_2 <- filter(POST_3, POST_3$Area<2)
PRE_3 <- filter(PRE_3, PRE_3$Area>0.05)
POST_3 <- filter(POST_3, POST_3$Area>0.05)
PRE_3 <- filter(PRE_3, PRE_3$Area<2)
POST_3 <- filter(POST_3, POST_3$Area<2)
PRE_4 <- filter(PRE_3, PRE_3$Area>0.05)
POST_4 <- filter(POST_3, POST_3$Area>0.05)
PRE_4 <- filter(PRE_3, PRE_3$Area<2)
POST_4 <- filter(POST_3, POST_3$Area<2)
#create dataframe
newdf<-rbind(PRE_1,POST_1,PRE_2,POST_2,PRE_3,POST_3,PRE_4,POST_4)
#create plots
MEAN <- ggplot(newdf, aes(x=newdf$type, y=newdf$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE", "POST")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("Mean")+ labs(x='',y='Fluorescence Intensity (a.u.)')
  

               
MEDIAN<-ggplot(newdf, aes(x=newdf$type, y=newdf$Median)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE", "POST")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("Median")+ labs(x='',y='Fluorescence Intensity (a.u.)')

# combine plots
figure_1 <- ggarrange(MEAN, MEDIAN, 
          labels = c("A", "B"),
          ncol = 2, nrow = 1)
figure_1


