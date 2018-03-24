# setting system locale for names in English
Sys.setlocale("LC_TIME", "en_GB.utf8")

# loading the original data set
collisions <- as.data.frame(read_csv("NYPD_Motor_Vehicle_Collisions.csv"))
collisions$POSIX_DATE <- lapply(collisions$DATE, function(x) as.POSIXct(x, format = "%m/%d/%Y"))

# subsetting the data set
last_year_collisions <- collisions[collisions$POSIX_DATE >= as.POSIXct("2017-03-23", format = "%Y-%m-%d"), !(names(collisions) == "POSIX_DATE")]

# doing some preprocessing for later use
last_year_collisions$WEEKDAY <- unlist(lapply(last_year_collisions$DATE, function(x) weekdays(as.Date(x, format = "%m/%d/%Y"))))
last_year_collisions$MONTH <- unlist(lapply(last_year_collisions$DATE, function(x) months(as.Date(x, format = "%m/%d/%Y"))))

# write the data to a file
write.csv(last_year_collisions, file = "last_year_collisions.csv")