
#Exploration of Initial Variables 

#Data Cleaning of State/District Entry 

summary(as.factor(dfhc$State.District))
plot(as.factor(dfhc$X4))

#All entries are Sabah/Kinabatangan. Other entries are blank rows or the initial row containing column names
#Likely want to drop missing rows at some point, not sure why they are being imported 

#Dropping 40 rows with no data 
dfhc <-subset(dfhc,X4 !="")

#Location (Town/Village/Plantation)
 
summary(as.factor(dfhc[, 5]))
plot(as.factor(dfhc[, 5]))
  
#Gender 
  
summary(as.factor(dfhc[, 6]))
plot(as.factor(dfhc[, 6]))

#Ethnic Group 

summary(as.factor(dfhc[, 10]))
ethnic <- tolower(dfhc[, 10])
unique(ethnic)
table(ethnic)

write.csv(as.data.frame(table(ethnic)),"out/EthnicGroups.csv", row.names=F )

unique(dfhc[, 10])
et<-table(dfhc $X10)
barplot(et)


