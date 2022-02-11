library(gsheet)
library(beepr)
library(readr)
library(stringr)

WHY DOES BEEP NOT ACCEPT HTTPS BUT GSHEET2TBL DOES???????
  gsheet::gsheet2tbl uses readr::read_csv, which uses gsheet::construct_download_url which uses stringr::str_extract



  
beep

  sound_path <- NULL
  if (is.na(sounds[sound]) || length(sounds[sound]) != 1) {
    if (is.character(sound)) {
      sound <- str_trim(sound)
      if (file.exists(sound)) {
        sound_path <- sound
      }
      else if (str_detect(sound, "^https://")) {
        warning("Can't currently use https urls, only http.")
      }
      else if (str_detect(sound, "^http://")) {
        temp_file <- tempfile(pattern = "")
        if (download.file(sound, destfile = temp_file, 
                          quiet = TRUE) == 0) {
          sound_path <- temp_file
        }
  
 
  
construct_download_url

  key <- stringr::str_extract(url, "[[:alnum:]_-]{30,}")
  if (is.null(sheetid) & stringr::str_detect(url, "gid=[[:digit:]]+")) {
    sheetid <- as.numeric(stringr::str_extract(stringr::str_extract(url, 
                                                                    "gid=[[:digit:]]+"), "[[:digit:]]+"))
  }
  address <- paste0("https://docs.google.com/spreadsheets/export?id=", 
                    key, "&format=", format)
  if (!is.null(sheetid)) {
    address <- paste0(address, "&gid=", sheetid)
  }
  return(address)


  
  
  
  str_extract
 
    switch(type(pattern), empty = stri_extract_first_boundaries(string, 
    pattern, opts_brkiter = opts(pattern)), bound = stri_extract_first_boundaries(string, 
    pattern, opts_brkiter = opts(pattern)), fixed = stri_extract_first_fixed(string, 
    pattern, opts_fixed = opts(pattern)), coll = stri_extract_first_coll(string, 
    pattern, opts_collator = opts(pattern)), regex = stri_extract_first_regex(string, 
    pattern, opts_regex = opts(pattern)))

  
  