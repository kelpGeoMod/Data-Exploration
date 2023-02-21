library(DataSpaceR)
writeNetrc(
  login = "jfrench_6", 
  password = "Happyday1!",
  netrcFile = "/Users/jfrench/.netrc",
  overwrite = TRUE # use getNetrcPath() to get the default path 
)


library(sys)
library(getPass)
library(httr)
# ---------------------------------SET UP ENVIRONMENT--------------------------------------------- #
dl_dir <- "/Users/jfrench/Documents/MEDS/Capstone/DATA/SST"
usr <- file.path("~")  # Retrieve user directory (for netrc file)
#if (usr == "") {usr = Sys.getenv("HOME")}    # If no user profile exists, use home directory
netrc <- file.path(usr,'.netrc', fsep = .Platform$file.sep) # Path to netrc file

# 1. Single file (this is just an example link, replace with your desired file to download):
files <- "https://opendap.earthdata.nasa.gov/collections/C2036880657-POCLOUD/granules/20140302090000-JPL-L4_GHRSST-SSTfnd-MUR25-GLOB-v02.0-fv04.2.dap.nc4"

# Loop through all files
for (i in 1:length(files)) {
  filename <-  tail(strsplit(files[i], '/')[[1]], n = 1) # Keep original filename
  
  # Write file to disk (authenticating with netrc) using the current directory/filename
  response <- GET(files[i], write_disk(filename, overwrite = TRUE), progress(),
                  config(netrc = TRUE, netrc_file = netrc), set_cookies("LC" = "cookies"))
  
  # Check to see if file downloaded correctly
  if (response$status_code == 200) {
    print(sprintf("%s downloaded at %s", filename, dl_dir))
  } else {
    print(sprintf("%s not downloaded. Verify that your username and password are correct in %s", filename, netrc))
  }
}
