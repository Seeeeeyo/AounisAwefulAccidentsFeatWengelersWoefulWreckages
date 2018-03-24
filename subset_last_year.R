# setting system locale for names in English
Sys.setlocale("LC_TIME", "en_GB.utf8")

# number of seconds in a year
year_in_seconds <- 3.1536e+7

# loading the original data set
collisions <- as.data.frame(read_csv("NYPD_Motor_Vehicle_Collisions.csv"))
collisions$NUMERIC_DATE <- lapply(collisions$DATE, function(x) as.numeric(as.POSIXct(x, format = "%m/%d/%Y")))

# subsetting the data set
last_year_time <- as.numeric(as.POSIXct("2018-03-23", format = "%Y-%m-%d")) - year_in_seconds
last_year_collisions <- collisions[collisions$NUMERIC_DATE >= last_year_time, !(names(collisions) == "NUMERIC_DATE")]

# doing some preprocessing for later use
last_year_collisions$WEEKDAY <- unlist(lapply(last_year_collisions$DATE, function(x) weekdays(as.Date(x, format = "%m/%d/%Y"))))
last_year_collisions$MONTH <- unlist(lapply(last_year_collisions$DATE, function(x) months(as.Date(x, format = "%m/%d/%Y"))))

# write the data to a file
write.csv(last_year_collisions, file = "last_year_collisions.csv")