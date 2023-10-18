

#* @get /version
function() {
  ejemplo <- fromJSON(
    '{"version" : "0.0.1"}'
  )
}


#* @param codigo World bank indicator code 
#* @get /indicator
function(indicator_code = "FP.CPI.TOTL.ZG") {

  url <- paste0("https://api.worldbank.org/v2/es/indicator/", 
                indicator_code, "?downloadformat=csv")
  download(url, "file.zip", mode = "wb")
  
  unzip("file.zip")
  
  selected_file <- list.files(pattern = "^API")
  
  gcs_upload(
    file = selected_file,
    bucket = "serviciobm",
    name = paste0(indicator_code, ".csv"),
    predefinedAcl = "bucketLevel"
  )
  
  file.remove( list.files(pattern = "*.csv"))

  return(indicator_code)
}

