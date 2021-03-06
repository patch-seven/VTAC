setwd('C:/R/VTAC')

install.packages("ggplot2")
install.packages("mapproj")
install.packages("ggmap") #note ggmap needed deducerspatial to be installed first before being called
install.packages("DeducerSpatial")

library(ggplot2)
library(mapproj)
require(maps)
require(ggmap)

#FUTURE IMPROVEMENT: ADD a loop function to run through all input files
#Read in 2016 Data files... will need to look at previous year files separately at another time. should try to match to current fields
offer_2016 <-c()
input_file <- c('C:/R/VTAC/RAW files/2016 SY Offer Files/380_offer_international_round0_18122015.txt')
offer_2016 <- rbind(offer_2016, read.fwf(input_file, widths2016))
input_file <- c('C:/R/VTAC/RAW files/2016 SY Offer Files/380_offer_international_round1_08012016.txt')
offer_2016 <- rbind(offer_2016, read.fwf(input_file, widths2016))
input_file <- c('C:/R/VTAC/RAW files/2016 SY Offer Files/380_offer_international_round2_04022016.txt')
offer_2016 <- rbind(offer_2016, read.fwf(input_file, widths2016))
input_file <- c('C:/R/VTAC/RAW files/2016 SY Offer Files/380_offer_round2_04022016.txt')
offer_2016 <- rbind(offer_2016, read.fwf(input_file, widths2016))
input_file <- c('C:/R/VTAC/RAW files/2016 SY Offer Files/380_offer_round3_15022016.txt')
offer_2016 <- rbind(offer_2016, read.fwf(input_file, widths2016))

#note the main offer file, round 1 domestic, had an error on line 4046 (additional line break. use an external text editor to fix.)
input_file <- c('C:/R/VTAC/RAW files/2016 SY Offer Files/380_offer_round1_15012016.txt')
offer_2016 <- rbind(offer_2016, read.fwf(input_file, widths2016))


#check for and remove any duplicate rows from different rounds? should this happen? no idea, but it is simple to remove dupes useing "unique"
offer_2016 <- unique(offer_2016)

#apply names to the data set, note only do this after inputting all the data, as rbind automatically checks colnames and tries to match
#Note you need to run the header input section below first. this is very long for checking so i put it below
names(offer_2016) <- header2016


#Set widths and headers from VTAC Data disctionary - set ALL columns whether in Masterfile or offerfile, or both
#This will need updated every year, as the file lengths change, but should serve as a good basis for now
widths2016 <- c(4, 9, 3, 1, 24, 17, 17, 10, 1, 25, 25, 25, 3, 4, 14, 12, 36, 25, 25, 25, 3, 4, 14, 12, 36, 1, 2, 7, 2, 16, 16, 16, 40, 24, 17, 17, 1, 10, 120, 120, 120, 10, 1, 1, 1, 1, 154, 1, 10, 1, 1, 1, 300, 300, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 68, 68, 10, 3, 3, 1, 1, 3, 3, 1, 3, 3, 93, 10, 1, 3, 3, 300, 300, 4, 1, 4, 1, 1, 40, 10, 40, 4, 36, 1, 426, 1, 5, 6, 5, 4, 4, 2, 4, 40, 36, 10, 1, 4, 1, 1060, 1, 3, 1, 11, 1, 1, 2, 2, 1, 4, 4, 1, 4, 1, 100, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 4, 4, 1, 2, 1, 1, 1, 1, 510)

header2016 <- c('Year of application',
                'VTAC ID Number',
                'Category',
                'Tertiary Entrance Requirement (TER) status',
                'Surname',
                'First Given Name',
                'Second Given Name',
                'Date Of Birth',
                'Gender',
                'Postal address line 1',
                'Postal address line 2',
                'Postal Suburb',
                'Postal State',
                'Postal Postcode',
                'Postal Overseas State/Province',
                'Postal Overseas Zip/Postcode',
                'Postal Country',
                'Residential address line 1',
                'Residential address line 2',
                'Residential Suburb',
                'Residential State',
                'Residential Postcode',
                'Residential Overseas State/Province',
                'Residential Overseas Zip/Postcode',
                'Residential Country',
                'ASGS rating of residential Australian postcode',
                'SEIFA percentile (population weighted) for residential Australian postcode',
                'SA1 for residential Australian address',
                'SEIFA percentile (population weighted) for SA1',
                'Home Phone Number',
                'Business Phone Number',
                'Mobile Phone',
                'Electronic mail address',
                'Previous Surname',
                'Previous First Given Name',
                'Previous Second Given Name',
                'Citizenship Status',
                'CHESSN',
                'Undergraduate preferences as at the time of VTAC timely applications close ',
                'Undergraduate preferences as at the time of VTAC late close and Early worklist',
                'Undergraduate preferences as at the time of main round worklist',
                'Course Code',
                'Prerequisite met?',
                'Offer Round',
                'Enrolment status',
                'Fee eligibility for Type 4 enrolled course',
                '11 repeats of fields 42 - 46 (for preferences 2 to 12)',
                'Offer type',
                'Course Code',
                'Offer Round',
                'Enrolment status',
                'Fee eligibility for Type 4 enrolled course',
                'Worklist remarks (Current Undergraduate offer)',
                'Institutional remarks (Current Undergraduate offer)',
                'Fee eligibility for Type 4 offered course',
                'VTAC Assessment Major 1',
                'VTAC Assessment Major 2',
                'VTAC Assessment Major 3',
                'VTAC Assessment Major 4',
                'VTAC Assessment Major 5',
                'VTAC Assessment Minor 1',
                'VTAC Assessment Minor 2',
                'VTAC Assessment Minor 3',
                'VTAC Assessment Minor 4',
                'VTAC Assessment Minor 5',
                'GET English language assessment',
                'GET preferences as at the time of VTAC timely applications close',
                'GET preferences as at the time of main round worklist',
                'Course Code applied',
                'Specialist teaching area A applied',
                'Specialist teaching area B applied',
                'Applicant will consider alternative methods ',
                'Offer Round',
                'Offered specialist teaching area A',
                'Offered specialist teaching area B',
                'Enrolment status',
                'Enrolled specialist teaching area A',
                'Enrolled specialist teaching area B',
                '3 repeats of fields 69-78 (for preferences 2, 3, and 4)',
                'Course Code',
                'Enrolment status',
                'Enrolled specialist teaching area A',
                'Enrolled specialist teaching area B',
                'Worklist remarks (Current GET offer)',
                'Institutional remarks (Current GET offer)',
                'Result Year',
                'Type of schooling indicator',
                'State/jurisdiction of year 12 claim',
                'Y12 eligibility flag as reported by state authority',
                'VTAC Indicator for Year',
                'Overseas year 12 award name',
                'School Code',
                'School Name',
                'School Postcode',
                'Country',
                'Verification of claim',
                '3 repeats of fields 86-96 (for next 3 studies)',
                'ATAR Type',
                'ATAR',
                'Achieved aggregate score',
                'ATAR Calculating Authority',
                'Post-Sec Year Started',
                'Post Sec Year Completed',
                'Post Sec Level',
                'Post Sec Institution Code',
                'Post Sec Institution Name',
                'Overseas Post Sec. Country',
                'Post Sec Student ID Number',
                'Post Secondary Completion',
                'Post Secondary Grade Point Average Result.',
                'Verification of claim',
                '10 repeats of fields 102-111 (for next 10 studies)',
                'STAT Type',
                'STAT Percentile', 
                'UMAT or ISAT type',
                'UMAT/ISAT identification',
                'VTAC personal history submission',
                'SEAS application (Special Entry Access Schemes)',
                'Educational attainment of first parent/guardian',
                'Educational attainment of second parent/guardian',
                'Where Applicant Was Born',
                'Country Born Code',
                'Year First Arrived In Australia',
                'Principal Language Spoken At Home',
                'Non-English Language  Code Spoken At Home ',
                'Aboriginal Australian and/or Torres Strait Islander descent',
                'Name and location of indigenous community',
                'Hearing Problem',
                'Learning Problem',
                'Medical Problem',
                'Mobility Problem',
                'Vision Problem',
                'Other Problem',
                'Applicant requires advice on disability support services',
                'VCAA Enhancement/Higher Education studies reported',
                'VET studies reported',
                'Study Count',
                'Result Year',
                'Study Code',
                'Study Type',
                'Study Score or old Subject  Mark',
                'Unit 1 Result',
                'Unit 2 Result',
                'Unit 3 Result',
                'Unit 4 result/Old Subject Grade',
                '34 repeats of fields 138-145 (for next 34 studies)')
  


#Lets Explore and start to check with data
?summary
summary(offer_2016)
str(offer_2016$ATAR)
summary(offer_2016$ATAR)

##### ATAR Distribution by gender

ggplot(offer_2016, aes(x=offer_2016$ATAR, fill=(as.factor(offer_2016$Gender))))+
  geom_histogram(bins=100)+
  coord_cartesian(xlim=c(60,100))

ggplot(offer_2016, aes(x=offer_2016$ATAR, fill=offer_2016$Gender)) + 
  geom_histogram(binwidth=.5, alpha=.5, position="identity")



##### Geocoding 

map("world","Australia")
map.cities(country="Australia", capitals = 3)

#Concatenate Adress columns for geocoding
offer_2016$NEWaddress <- paste(offer_2016[,10], offer_2016[,11], offer_2016[,12], offer_2016[,13], offer_2016[,14], offer_2016[,15], sep =",")
#check the contatenation looks ok : looks like the empty spaces have been kept
#FUTURE IMPROVEMENT - add "Australia" into those blank in column 15, also try to remove blank spaces
head(offer_2016$NEWaddress)
#set up temp dataframe to catch geocoded lonitudes and latitudes
temp <- c()
#geocode them addresses!! note google API has limit of 2500 per day
?geocode
geocodeQueryCheck()
temp <- geocode(offer_2016$NEWaddress[1:400])

#seems to have worked, my temp file contains 400 observations
#Note error message : There were 12 warnings (use warnings() to see them)
warnings()
#Yup those 12 look like difficult addresses, a few GPO boxes, and internationals

#Lets grab a map of Melbourne to overlay, zoom appears to be inverse, ie small number = big zoom, 10 looks like a reasonable zoom for metro melbourne
Melbourne <- get_map('Melbourne', zoom=10)
Melbournemap <- ggmap(Melbourne)

#density fill to show spread... fill=..level.. shows the counts (scale_fill_gradient selects colour range), alpha sets the transparency (guide =F to not show a separate grey scale for this)
#can still play around with numbers to get transparency and colour looking good - adjusting bins = better coverage and granularity over smaller numbers
Melbournemap2 + 
  stat_density2d(aes(x = lon, y = lat, 
  fill = ..level.., alpha=..level..),size = 1, bins=80,
  data = temp, geom = 'polygon') +
  scale_fill_gradient(low='Blue', high='Red')+
  scale_alpha(range = c(.4, .75), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 1.5, barheight = 10))

#Point fills maybe show ATAR or something??
#create temp_new from temp, add ATAR and gender
temp_new <- cbind(temp, 'Gender' = offer_2016$Gender[1:400], 'ATAR' = offer_2016$ATAR[1:400])

Melbournemap2 <- qmap('Melbourne', zoom = 10, color = 'bw', legend = 'topleft')
Melbournemap2 +
  geom_point(aes(x = lon, y = lat,
  size = ATAR ,colour = Gender), 
  data = temp_new)

#OK THIS LOOKS REALLY GOOD. 


#lets use up the rest of the geocding for today... should be able to get the entire lot geocoded in ~5 days.
#Masterfile would take ~30 days... might need a to try the google API licence
temp2 <- geocode(offer_2016$NEWaddress[401:2401])
temp2_new <- rbind(temp, temp2)
temp2_new <- cbind(temp2_new, 'Gender' = offer_2016$Gender[1:2401], 'ATAR' = offer_2016$ATAR[1:2401])

Melbournemap3 <- qmap('Melbourne', zoom = 7, color = 'bw', legend = 'topleft')

Melbournemap3 + 
  stat_density2d(aes(x = lon, y = lat, 
                     fill = ..level.., alpha=..level..),size = 3, bins=40,
                 data = temp2_new, geom = 'polygon') +
  scale_fill_gradient(low='Blue', high='Red')+
  scale_alpha(range = c(.4, .75), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 1.5, barheight = 10))

Sydney <- qmap('Sydney', zoom = 11, color = 'bw', legend = 'topleft')

Sydney + 
  stat_density2d(aes(x = lon, y = lat, 
                     fill = ..level.., alpha=..level..),size = 1, bins=10,
                 data = temp2_new, geom = 'polygon') +
  scale_fill_gradient(low='Blue', high='Red')+
  scale_alpha(range = c(.4, .75), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 1.5, barheight = 10))


Sydney +
  geom_point(aes(x = lon, y = lat,
                 size = ATAR ,colour = Gender), 
             data = temp2_new)

Australia <- qmap('Australia', zoom =4, color='bw',legend ='topleft')
Australia+
  geom_point(aes(x = lon, y = lat,
  size = ATAR ,colour = Gender), 
  data = temp2_new)


World <- qmap('World', zoom=1,color='bw',legend ='topleft')
World2map+
  geom_point(aes(x = lon, y = lat,
                 size = ATAR ,colour = Gender), 
             data = temp2_new)
#hmm world does not seem to work at zoom=1
#try other package
World2 <- get_map('World', zoom=2)
World2map <- ggmap(World2)


#OKIE DOKIE GIT set up