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
setwd(dl_dir)
usr <- file.path("~")  # Retrieve user directory (for netrc file)
#if (usr == "") {usr = Sys.getenv("HOME")}    # If no user profile exists, use home directory
netrc <- file.path(usr,'.netrc', fsep = .Platform$file.sep) # Path to netrc file

# read sst name and address csv file
file_addresses <- read_csv("sst_file_addresses.csv")

# 1. Single file (this is just an example link, replace with your desired file to download):
#files <- "https://opendap.earthdata.nasa.gov/collections/C1996881146-POCLOUD/granules/20210804090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.dap.nc4?dap4.ce=/mask%5B0:1:0%5D%5B12299:12499%5D%5B5899:6099%5D;/analysed_sst%5B0:1:0%5D%5B12299:12499%5D%5B5899:6099%5D;/dt_1km_data%5B0:1:0%5D%5B12299:12499%5D%5B5899:6099%5D;/analysis_error%5B0:1:0%5D%5B12299:12499%5D%5B5899:6099%5D;/lat%5B12299:12499%5D;/lon%5B5899:6099%5D;/time%5B0:1:0%5D"


# 2. List of files (these are just example links, replace with your desired files to download:
files <- file_addresses$address[1:4]
file_names <- file_addresses$file_name[1:4]

print(files)
# 3. Textfile containing links (just an example, replace with your text file location):
#files <- readLines("C:/datapool_downloads/URL_file_list.txt", warn = FALSE)

# Loop through all files
for (i in 1:length(files)) {
  filename <-  file_names[i] # Keep original filename
  # Write file to disk (authenticating with netrc) using the current directory/filename
  response <- GET(files[i], write_disk(path = filename, overwrite = TRUE), progress(),
                  config(netrc = TRUE, netrc_file = netrc), set_cookies("LC" = "cookies"))
  
  # Check to see if file downloaded correctly
  if (response$status_code == 200) {
    print(sprintf("%s downloaded at %s", filename, dl_dir))
  } else {
    print(sprintf("%s not downloaded. Verify that your username and password are correct in %s", filename, netrc))
  }
}

file <- nc_open("/Users/jfrench/Documents/MEDS/Capstone/DATA/SST/D")

sst <- ncvar_get(file, "analysed_sst")
sst_rast <- raster(sst)

tmap_mode(mode = "view")
tm_shape(sst_rast)+
  tm_raster()
