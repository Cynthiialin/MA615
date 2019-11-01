

library(DBI)
library(RSQLite)
#con<-dbConnect(SQLite(),"chinook.db")
#dbGetQuery(con,"Select FirstName, LastName
           # FROM Customers WHERE Country= 'Brazi';")

library(tidyverse)
library(readxl)
library(dplyr)


#remove NA misclassifications and white space in each field


contrib_all <- read_xlsx("Top MA Donors 2016-2020.xlsx", sheet="Direct Contributions JFC Dist",na = c("", "N/A", "NA"), trim_ws = TRUE)
JFC<-read_xlsx("Top MA Donors 2016-2020.xlsx",sheet="JFC Contributions",na = c("", "N/A", "NA"), trim_ws = TRUE)


contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = ", ",replacement = ",")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "\\s\\w*",replacement = "")

(co<-unique(contrib_all$contrib))
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = ",,",replacement = "")

(co<-unique(contrib_all$contrib))

contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "HN,*",replacement = "HN")
(co<-unique(contrib_all$contrib))

contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "E\\sH",replacement = "E")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "H\\sH",replacement = "H")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "OS,",replacement = "OS")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "RD\\sB",replacement = "RD")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "AN\\sB",replacement = "AN")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "LD\\sMR",replacement = "LD")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "TA\\sS",replacement = "TA")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "UL\\sL",replacement = "UL")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "AN\\sS",replacement = "AN")
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "CE\\sH",replacement = "CE")

#merge two dataframes horizontally
contrib_all<-rbind(contrib_all,JFC)
contrib_all<-select (contrib_all,-c(ultorg))
contrib_all<-na.omit(contrib_all)

#Removing duplicate data entries
contrib_all <- contrib_all %>%
  distinct()

#1NF
#There are no repeating groups.
#All the primary keys are defined.
#All attributes are dependent on the primary key.Eliminate duplicative columns from the same table.
#Create separate tables for each group of related data and identify each row with a
#unique column or set of columns (the primary key).

contributors<-select(contrib_all,contribid,contrib,City,State,Zip,fam,Fecoccemp,date,amount,type)
orgs<-select(contrib_all,orgname)
recipients<-select(contrib_all,recipid,recipient,party,recipcode,cmteid)
cycle<-select(contrib_all,cycle,fectransid)

#2NF
#contains no partial dependencies
#Remove subsets of data that apply to multiple rows of a table and place them in separate tables.
#Create relationships between these new tables and their predecessors through the use of foreign keys
contributors<-select(contrib_all,contribid,contrib,City,State,Zip,date,amount)
contributors_tbl<-select(contrib_all,contrib,Fecoccemp,fam,type)
orgs<-select(contrib_all,orgname)
recipients<-select(contrib_all,recipid,recipient,party,recipcode,cmteid)
cycle<-select(contrib_all,cycle,fectransid)

#3NF
#contains no transitive dependencies (where a non-key attribute is dependent on the primary key through another non-key attribute
#Remove columns that are not dependent upon the primary key.
contributors<-select(contrib_all,contrib,contribid,City,State,Zip,date,amount)
contributors_tbl<-select(contrib_all,contrib,Fecoccemp,fam,type)
orgs<-select(contrib_all,contribid,orgname)
recipients<-select(contrib_all,recipid,recipient,contribid)
recipients_type<-select(contrib_all,recipid,party,recipcode,cmteid,contribid)
cycle<-select(contrib_all,contribid,cycle,fectransid)
donors<-select(contrib_all,contrib,contribid)
#A relation is in 4NF if it has no multi-valued dependencies
#Removing duplicate data entries
contributors <- contributors %>%
  distinct()
contributors_tbl <- contributors_tbl %>%
  distinct()
orgs <- orgs %>%
  distinct()
recipients <- recipients %>%
  distinct()
recipients_type <- recipients_type %>%
  distinct()
cycle <- cycle %>%
  distinct()
donors <- donors %>%
  distinct()

polcont<-dbConnect(SQLite(),"pol_cont")

dbWriteTable(polcont, "contributors", contributors)
dbWriteTable(polcont, "contributors_tbl", contributors_tbl)
dbWriteTable(polcont, "orgs", orgs)
dbWriteTable(polcont, "recipients", recipients)
dbWriteTable(polcont, "recipients_type", recipients_type)
dbWriteTable(polcont, "cycle", cycle)
dbWriteTable(polcont, "donors", donors)
