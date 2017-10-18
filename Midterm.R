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
elninomonthzoo$ZooDateTime <- str_c(elninomonthzoo$Date, " ", elninomonthzoo$tow_time)

#edit macrozoo lat/long format
install.packages("measurements")
MacroZoo <- elninomonthzoo
MacroZoo$LAT <- str_c(MacroZoo$lat_deg, " ", MacroZoo$lat_min)
MacroZoo$LATdec = measurements::conv_unit(MacroZoo$LAT, from = 'deg_dec_min', to = 'dec_deg')
MacroZoo$LONG <- str_c(MacroZoo$lon_deg, " ", MacroZoo$lon_min)
MacroZoo$LONGdec = measurements::conv_unit(MacroZoo$LONG, from = 'deg_dec_min', to = 'dec_deg')
MacroZoo$LONGdec = paste("-", MacroZoo$LONGdec, sep="")

#write macrozoo table
write.table(MacroZoo, "MacroZoo.txt", sep="\t", row.names=TRUE)

#edit egg date/time format
E <- eggs
E$DateTime <- eggs$time_UTC
as.POSIXct(E$DateTime, "%m-%d-%Y %H:%M:%S")
E$YYYY <- year(as.POSIXct(E$DateTime,"%m-%d-%Y %H:%M:%S" ))
E$MM <- month((as.POSIXct(E$DateTime,"%m-%d-%Y %H:%M:%S" )))
E$MM <- sprintf("%02d", E$MM)
elninoyearegg <- subset(E, YYYY >= 1997 & YYYY <= 1998)
elninoyearegg$DateEdit <- elninoyearegg$DateTime
elninoyearegg$DateEdit = gsub('.{9}$', '', elninoyearegg$DateEdit)
elninomonthegg <- subset(elninoyearegg, DateEdit >= "1997-07-01" & DateEdit <= "1998-06-22")

#edit egg anch & sard
elninomonthegg$Sard <- as.numeric(elninomonthegg$sardine_eggs_count)
elninomonthegg$Anch <- as.numeric(elninomonthegg$anchovy_eggs_count)
elninomonthegg$SardAnch <- (elninomonthegg$Sard + elninomonthegg$Anch)/2

#write egg table
write.table(elninomonthegg, "Egg.txt", sep="\t", row.names=TRUE)
