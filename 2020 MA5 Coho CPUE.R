# Data contain multiple records per date; summarize number of coho
# and number of anglers by date
numCoho=setNames(aggregate(wdfw_creel_data$Coho, list(wdfw_creel_data$date),FUN=sum),c("Date_in", "Coho"))
numAngler=setNames(aggregate(wdfw_creel_data$Anglers, list(wdfw_creel_data$date),FUN=sum),c("Date_in", "Anglers"))

# Merge number of coho and number of anglers by date
together=merge(numCoho,numAngler,by="Date_in")

# Calculate CPUE
together["CPUE"]=together["Coho"]/together["Anglers"]

# Format dates
together$date1=format(as.Date(together$Date_in, "%b %d, %Y"), "%d %B %Y")
together$Date=as.Date(together$date1, "%d %B %Y")

# Subset on summer months
together$Month=substr(together$Date_in,1,3)
Summer<-together[which(together$Month=='Jul' | together$Month=='Aug' | together$Month=='Sep' | together$Month=='Oct'),]

# Drop unwanted vars
wantVars<-c("Anglers", "Coho", "CPUE", "Date")
Summer<-Summer[wantVars]
Summer<-Summer[order( Summer$Date ),]

# Graph?
ggplot(Summer, aes(x=Date,y=CPUE)) + geom_bar(stat="identity")

