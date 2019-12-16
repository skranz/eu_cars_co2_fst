# Download ZIP with CSV
# from https://www.eea.europa.eu/data-and-maps/data/co2-cars-emission-16
# and save as fst file.

run = function() {
  # Example 2018
  year = 2018
  url ="http://ftp.eea.europa.eu/www/co2/CO2_passenger_cars_v17_csv.zip"
  download.and.convert(year, url)  
}


download.and.convert = function(year, url) {
  library(fst)
  library(rio)
  library(dplyr)
  
  fst.file = paste0("cars",year,".fst")
  zip.file = paste0("cars",year,".zip")
  if (file.exists(fst.file)) next
  
  url = urls$url[i]
  
  if (!file.exists(zip.file))
    download.file(url, zip.file)
  
  # Note R unzip does not work for 2018 data
  # unzip(zip.file)

  # Use linux unzip instead  
  cmd = paste0("unzip ", zip.file)
  system(cmd)
  csv.file = "CO2_passenger_cars.csv"
  #csv.file = list.files(pattern=glob2rx("*.csv"))[1]
  
  dat = try(rio::import(csv.file))
  
  # Some files are UTF-16 encoded. Use good old read.csv to deal with it
  if (is(dat, "try-error")) {
    dat = read.csv(csv.file,fileEncoding = "UTF-16", sep="\t")
  }
  
  # Write fst file with maximum compression
  write_fst(dat, fst.file,compress = 100)
  
  # Remove large csv.file
  file.remove(csv.file) 
}



