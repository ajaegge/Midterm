#midterm

#load libraries
library("lubridate")
library("plyr")
library("stringr")
library("pastecs")
library("oce")

#edit macrozoo date/time format
M <- macrozoo_1_
M$DATE <- M$tow_date
M$DATE = gsub('/', '-', M$DATE)
as.Date(M$DATE, "%m-%d-%Y")
M$YYYY <- year(as.Date(M$DATE, "%m-%d-%Y"))
as.numeric(M$YYYY)
M$MM <- month(as.Date(M$DATE, "%m-%d-%Y"))
M$MM <- sprintf("%02d", M$MM)
M$DD <- day(as.Date(M$DATE, "%m-%d-%Y"))
elninoyearzoo <- subset(M, YYYY >= 1997 & YYYY <= 1998)
elninoyearzoo$Date <- str_c(elninoyearzoo$YYYY,"-",elninoyearzoo$MM,"-",elninoyearzoo$DD)
as.Date(elninoyearzoo$Date, "%Y-%m-%d")
elninomonthzoo <- subset(elninoyearzoo, Date >= "1997-07-01" & Date <= "1998-06-22")
