# 20 08 2020
# This is a fixed version of the analysis of the AB-FRET test
# the image data was collected on 06-08-2020
# the data was collected using the ImageJ macro posted in github.


####### Checking automated data retrieval


#setwd
setwd("/Volumes/NO NAME/conf/SynFRET_data/AB-FRET/DATA_automated")
rm(list = ls())
library(readr)
library(ggplot2)
library(ggsignif)
library(boot)
library(ggpubr)



#CA_1
PRE_1 <- read_csv("pre1.csv")
POST_1 <- read_csv("post1.csv")
PRE_1$type<-'PRE (n=6004)'
POST_1$type<-'POST (n=6042)'
newdf1<-rbind(PRE_1,POST_1)
gg1 <- ggplot(newdf1, aes(x=newdf1$type, y=newdf1$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=6004)", "POST (n=6042)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_1")+ labs(x='',y='Fluorescence Intensity (a.u.)')

ks.test(PRE_1$Mean,POST_1$Mean)
#?ks.test()

#CA_2
PRE_2 <- read_csv("pre2.csv")
POST_2 <- read_csv("post2.csv")
PRE_2$type<-'PRE (n=5128)'
POST_2$type<-'POST (n=4997)'
newdf2<-rbind(PRE_2,POST_2)
gg2 <- ggplot(newdf2, aes(x=newdf2$type, y=newdf2$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5128)", "POST (n=4997)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_2")+ labs(x='',y='Fluorescence Intensity (a.u.)')



#CA_3
PRE_3 <- read_csv("pre3.csv")
POST_3 <- read_csv("post3.csv")
PRE_3$type<-'PRE (n=7409)'
POST_3$type<-'POST (n=7409)'
newdf3<-rbind(PRE_3,POST_3)
gg3 <- ggplot(newdf3, aes(x=newdf3$type, y=newdf3$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=7409)", "POST (n=7409)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_3")+ labs(x='',y='Fluorescence Intensity (a.u.)')



#CA_4
PRE_4 <- read_csv("pre4.csv")
POST_4 <- read_csv("post4.csv")
PRE_4$type<-'PRE (n=7125)'
POST_4$type<-'POST (n=7091)'
newdf4<-rbind(PRE_4,POST_4)
gg4 <- ggplot(newdf4, aes(x=newdf4$type, y=newdf4$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=7125)", "POST (n=7091)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_4")+ labs(x='',y='Fluorescence Intensity (a.u.)')


# cortex_1
CPRE_1 <- read_csv("cortex_pre1.csv")
CPOST_1 <- read_csv("cortex_post1.csv")
CPRE_1$type<-'PRE (n=7044)'
CPOST_1$type<-'POST (n=6990)'
newdf5<-rbind(CPRE_1,CPOST_1)
gg5 <- ggplot(newdf5, aes(x=newdf5$type, y=newdf5$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=7044)", "POST (n=6990)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("Cortex_1")+ labs(x='',y='Fluorescence Intensity (a.u.)')




# cortex_2
CPRE_2 <- read_csv("cortex_pre2.csv")
CPOST_2 <- read_csv("cortex_post2.csv")
CPRE_2$type<-'PRE (n=7044)'
CPOST_2$type<-'POST (n=6813)'
newdf6<-rbind(CPRE_2,CPOST_2)
gg6<-ggplot(newdf6, aes(x=newdf6$type, y=newdf6$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=7044)", "POST (n=6813)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("Cortex_2") + labs(x='',y='Fluorescence Intensity (a.u.)')


ggarrange(gg1,gg2,gg3,gg4,gg5,gg6, 
          labels = c("A", "B", "C", "D", "E", "F"),
          ncol = 3, nrow = 2)



############## --- STAT --- TESTS ---########



#because the data distribution in wide, I am not sure if we can apply wilcoxon. But how about if our data is log'ed?

wilcox.test(log10(PRE_1$Mean),log10(POST_1$Mean))

# because even log10 shows the same wilcoxon result, only bootsraping could show a smaller difference value

# also, what about if we filter out the data?
# in this case if we filter out puncta that are smaller than 0.05


library(dplyr)  
# use dplyr library
# new_ds <- filter(dataset, filter_of_interest)





#CA_1
PRE_1 <- read_csv("pre1.csv")
POST_1 <- read_csv("post1.csv")
PRE_1 <- filter(PRE_1, PRE_1$Area>0.05)
POST_1 <- filter(POST_1, POST_1$Area>0.05)
PRE_1 <- filter(PRE_1, PRE_1$Area<2)
POST_1 <- filter(POST_1, POST_1$Area<2)
PRE_1$type<-'PRE (n=4690)'
POST_1$type<-'POST (n=4751)'
newdf1<-rbind(PRE_1,POST_1)
gg1 <- ggplot(newdf1, aes(x=newdf1$type, y=newdf1$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=4690)", "POST (n=4751)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_1")+ labs(x='',y='Fluorescence Intensity (a.u.)')

ks.test(PRE_1$Mean,POST_1$Mean)
#?ks.test()

#CA_2
PRE_2 <- read_csv("pre2.csv")
POST_2 <- read_csv("post2.csv")
PRE_2 <- filter(PRE_2, PRE_2$Area>0.05)
POST_2 <- filter(POST_2, POST_2$Area>0.05)
PRE_2 <- filter(PRE_2, PRE_2$Area<2)
POST_2 <- filter(POST_2, POST_2$Area<2)
PRE_2$type<-'PRE (n=4002)'
POST_2$type<-'POST (n=3849)'
newdf2<-rbind(PRE_2,POST_2)
gg2 <- ggplot(newdf2, aes(x=newdf2$type, y=newdf2$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=4002)", "POST (n=3849)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_2")+ labs(x='',y='Fluorescence Intensity (a.u.)')



#CA_3
PRE_3 <- read_csv("pre3.csv")
POST_3 <- read_csv("post3.csv")
PRE_3 <- filter(PRE_3, PRE_3$Area>0.05)
POST_3 <- filter(POST_3, POST_3$Area>0.05)
PRE_3 <- filter(PRE_3, PRE_3$Area<2)
POST_3 <- filter(POST_3, POST_3$Area<2)
PRE_3$type<-'PRE (n=5785)'
POST_3$type<-'POST (n=5767)'
newdf3<-rbind(PRE_3,POST_3)
gg3 <- ggplot(newdf3, aes(x=newdf3$type, y=newdf3$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5785)", "POST (n=5767)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_3")+ labs(x='',y='Fluorescence Intensity (a.u.)')



#CA_4
PRE_4 <- read_csv("pre4.csv")
POST_4 <- read_csv("post4.csv")
PRE_4 <- filter(PRE_4, PRE_4$Area>0.05)
POST_4 <- filter(POST_4, POST_4$Area>0.05)
PRE_4 <- filter(PRE_4, PRE_4$Area<2)
POST_4 <- filter(POST_4, POST_4$Area<2)
PRE_4$type<-'PRE (n=5627)'
POST_4$type<-'POST (n=5458)'
newdf4<-rbind(PRE_4,POST_4)
gg4 <- ggplot(newdf4, aes(x=newdf4$type, y=newdf4$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5627)", "POST (n=5458)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_4")+ labs(x='',y='Fluorescence Intensity (a.u.)')


# cortex_1
CPRE_1 <- read_csv("cortex_pre1.csv")
CPOST_1 <- read_csv("cortex_post1.csv")
CPRE_1 <- filter(CPRE_1, CPRE_1$Area>0.05)
CPOST_1 <- filter(CPOST_1, CPOST_1$Area>0.05)
CPRE_1 <- filter(CPRE_1, CPRE_1$Area<2)
CPOST_1 <- filter(CPOST_1, CPOST_1$Area<2)
CPRE_1$type<-'PRE (n=5641)'
CPOST_1$type<-'POST (n=5584)'
newdf5<-rbind(CPRE_1,CPOST_1)
gg5 <- ggplot(newdf5, aes(x=newdf5$type, y=newdf5$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5641)", "POST (n=5584)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("Cortex_1")+ labs(x='',y='Fluorescence Intensity (a.u.)')




# cortex_2
CPRE_2 <- read_csv("cortex_pre2.csv")
CPOST_2 <- read_csv("cortex_post2.csv")
CPRE_2 <- filter(CPRE_2, CPRE_2$Area>0.05)
CPOST_2 <- filter(CPOST_2, CPOST_2$Area>0.05)
CPRE_2 <- filter(CPRE_2, CPRE_2$Area<2)
CPOST_2 <- filter(CPOST_2, CPOST_2$Area<2)
CPRE_2$type<-'PRE (n=5641)'
CPOST_2$type<-'POST (n=5473)'
newdf6<-rbind(CPRE_2,CPOST_2)
gg6<-ggplot(newdf6, aes(x=newdf6$type, y=newdf6$Mean)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5641)", "POST (n=5473)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("Cortex_2") + labs(x='',y='Fluorescence Intensity (a.u.)')


ggarrange(gg1,gg2,gg3,gg4,gg5,gg6, 
          labels = c("A", "B", "C", "D", "E", "F"),
          ncol = 3, nrow = 2)

########### MEDIANS #################

# now let us compare the MEDIANS with the filtered data

#CA_1
PRE_1 <- read_csv("pre1.csv")
POST_1 <- read_csv("post1.csv")
PRE_1 <- filter(PRE_1, PRE_1$Area>0.05)
POST_1 <- filter(POST_1, POST_1$Area>0.05)
PRE_1 <- filter(PRE_1, PRE_1$Area<2)
POST_1 <- filter(POST_1, POST_1$Area<2)
PRE_1$type<-'PRE (n=4690)'
POST_1$type<-'POST (n=4751)'
newdf1<-rbind(PRE_1,POST_1)
gg1 <- ggplot(newdf1, aes(x=newdf1$type, y=newdf1$Median)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=4690)", "POST (n=4751)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_1")+ labs(x='',y='Fluorescence Intensity (a.u.)')

ks.test(PRE_1$Mean,POST_1$Mean)
#?ks.test()

#CA_2
PRE_2 <- read_csv("pre2.csv")
POST_2 <- read_csv("post2.csv")
PRE_2 <- filter(PRE_2, PRE_2$Area>0.05)
POST_2 <- filter(POST_2, POST_2$Area>0.05)
PRE_2 <- filter(PRE_2, PRE_2$Area<2)
POST_2 <- filter(POST_2, POST_2$Area<2)
PRE_2$type<-'PRE (n=4002)'
POST_2$type<-'POST (n=3849)'
newdf2<-rbind(PRE_2,POST_2)
gg2 <- ggplot(newdf2, aes(x=newdf2$type, y=newdf2$Median)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=4002)", "POST (n=3849)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_2")+ labs(x='',y='Fluorescence Intensity (a.u.)')



#CA_3
PRE_3 <- read_csv("pre3.csv")
POST_3 <- read_csv("post3.csv")
PRE_3 <- filter(PRE_3, PRE_3$Area>0.05)
POST_3 <- filter(POST_3, POST_3$Area>0.05)
PRE_3 <- filter(PRE_3, PRE_3$Area<2)
POST_3 <- filter(POST_3, POST_3$Area<2)
PRE_3$type<-'PRE (n=5785)'
POST_3$type<-'POST (n=5767)'
newdf3<-rbind(PRE_3,POST_3)
gg3 <- ggplot(newdf3, aes(x=newdf3$type, y=newdf3$Median)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5785)", "POST (n=5767)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_3")+ labs(x='',y='Fluorescence Intensity (a.u.)')



#CA_4
PRE_4 <- read_csv("pre4.csv")
POST_4 <- read_csv("post4.csv")
PRE_4 <- filter(PRE_4, PRE_4$Area>0.05)
POST_4 <- filter(POST_4, POST_4$Area>0.05)
PRE_4 <- filter(PRE_4, PRE_4$Area<2)
POST_4 <- filter(POST_4, POST_4$Area<2)
PRE_4$type<-'PRE (n=5627)'
POST_4$type<-'POST (n=5458)'
newdf4<-rbind(PRE_4,POST_4)
gg4 <- ggplot(newdf4, aes(x=newdf4$type, y=newdf4$Median)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5627)", "POST (n=5458)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("CA3_4")+ labs(x='',y='Fluorescence Intensity (a.u.)')


# cortex_1
CPRE_1 <- read_csv("cortex_pre1.csv")
CPOST_1 <- read_csv("cortex_post1.csv")
CPRE_1 <- filter(CPRE_1, CPRE_1$Area>0.05)
CPOST_1 <- filter(CPOST_1, CPOST_1$Area>0.05)
CPRE_1 <- filter(CPRE_1, CPRE_1$Area<2)
CPOST_1 <- filter(CPOST_1, CPOST_1$Area<2)
CPRE_1$type<-'PRE (n=5641)'
CPOST_1$type<-'POST (n=5584)'
newdf5<-rbind(CPRE_1,CPOST_1)
gg5 <- ggplot(newdf5, aes(x=newdf5$type, y=newdf5$Median)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5641)", "POST (n=5584)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("Cortex_1")+ labs(x='',y='Fluorescence Intensity (a.u.)')




# cortex_2
CPRE_2 <- read_csv("cortex_pre2.csv")
CPOST_2 <- read_csv("cortex_post2.csv")
CPRE_2 <- filter(CPRE_2, CPRE_2$Area>0.05)
CPOST_2 <- filter(CPOST_2, CPOST_2$Area>0.05)
CPRE_2 <- filter(CPRE_2, CPRE_2$Area<2)
CPOST_2 <- filter(CPOST_2, CPOST_2$Area<2)
CPRE_2$type<-'PRE (n=5641)'
CPOST_2$type<-'POST (n=5473)'
newdf6<-rbind(CPRE_2,CPOST_2)
gg6<-ggplot(newdf6, aes(x=newdf6$type, y=newdf6$Median)) + 
  geom_violin(fill='#A4A4A4', color="darkred") + 
  geom_signif(comparisons = list(c("PRE (n=5641)", "POST (n=5473)")), 
              map_signif_level=TRUE, test = 'wilcox.test')+
  stat_summary(fun.data="mean_sdl",geom="crossbar", width=0.2 )+
  ggtitle("Cortex_2") + labs(x='',y='Fluorescence Intensity (a.u.)')


ggarrange(gg1,gg2,gg3,gg4,gg5,gg6, 
          labels = c("A", "B", "C", "D", "E", "F"),
          ncol = 3, nrow = 2)

