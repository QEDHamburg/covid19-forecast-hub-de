# Author: Konstantin G�rgen
# Date: Sat May 09 12:14:22 2020
# --------------
# Modification: Added Submission and Forecast date
# Author: Konstantin G�rgen
# Date: 18.05.2020
# --------------

##File to read in Imperial Forecasts
source("Imperial-processing_Germany.R")

#make sure your wd is in the same folder as the file that was sourced,
#i.e. in data-raw/Imperial

#read in file paths and delete those without Germany in them
filepaths <- list.files(pattern = "ensemble_model_predictions", recursive =TRUE,full.names = TRUE)

#only take those where Germany was reported
reported_countries<-list()
germany_reported<-rep(NA,length(filepaths))

for(i in 1:length(filepaths))
{
  reported_countries[[i]]<-names(readRDS(filepaths[i])[[1]])
  germany_reported[i]<-as.logical(sum(reported_countries[[i]]=="Germany"))

}
filepaths<-filepaths[germany_reported]

#write final files

for(i in 1:length(filepaths)){
  formatted_file_1 <- format_imperial(path=filepaths[i],ens_model=1)
  formatted_file_2 <- format_imperial(path=filepaths[i],ens_model=2)

  date<-get_date(filepaths[i])
  
  write_csv(formatted_file_1,
            path = paste0("../../data-processed/Imperial-ensemble1/",
                          date,
                          "-Germany-Imperial-ensemble1.csv"))
  write_csv(formatted_file_2,
            path = paste0("../../data-processed/Imperial-ensemble2/",
                          date,
                          "-Germany-Imperial-ensemble2.csv"))
}
