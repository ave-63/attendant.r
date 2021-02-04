## USER OPTIONS:

## Path to folder containing all your downloaded csv files. You must edit this!
## Windows format example:
## INPUT_DIRECTORY <- "C:\\Users\\your-username\\Downloads\\"
## Mac/Linux example:
INPUT_DIRECTORY <- "/home/ben/Dropbox/Courses/227/r_stuff/attendant/"

## Path to folder where you want your result csv files to go. You must edit this!
## Windows format example:
## OUTPUT_DIRECTORY <- "C:\\Users\\your-username\\Downloads\\"
## Mac/Linux example:
OUTPUT_DIRECTORY <- "/home/ben/Dropbox/Courses/227/r_stuff/attendant/"

## The year (string)
YEAR <- "2021"

if(!require("stringi", quietly = TRUE, character.only = TRUE)){
    install.packages("stringi", character.only = TRUE)
}
library("stringi", quietly = TRUE, character.only = TRUE)
if(!require("dplyr", quietly = TRUE, character.only = TRUE)){
    install.packages("dplyr", character.only = TRUE)
}
library("dplyr", quietly = TRUE, character.only = TRUE)

options(stringsAsFactors=FALSE)

## Takes cols, a vector of column names, eg "Name" "We_2.10" "Mo_2.8" "Mo_2.15"
## and returns them in date order, eg "Name" "Mo_2.8" "We_2.10" "Mo_2.15"
sort_cols <- function(cols){
   mat <- stri_match_first_regex(cols, '\\w+_(\\d+)\\.(\\d+)') 
   cdf <- data.frame(colname = mat[,1], month = strtoi(mat[,2]), date = strtoi(mat[,3]))
   cdf <- filter(cdf, !is.na(colname)) ## "Name" created NA when matching regex
   cdf <- cdf[order(cdf$month, cdf$date),] ## Sort by month, then date
   append(c("Name"), cdf$colname) ## Put "Name" back
}

## opposite of make.names: make.headings("Mo_2.8") gives "Mo_2-8"
make.headings <- function(names){
    parts <- stri_match_first_regex(names, '(.+)\\.(.+)')
    paste0(parts[,2], "-", parts[,3])
}

## Parse file names
input_filenames = list.files(path = INPUT_DIRECTORY, pattern = ".+\\.csv")
output_filenames = list.files(path = OUTPUT_DIRECTORY, pattern = ".+\\.csv")
input_matches <- stri_match_first_regex(input_filenames,
   '(\\w+)_att_(\\d+-\\d+)\\.csv$')
output_matches <- stri_match_first_regex(output_filenames, 'attendance_(\\w+)\\.csv$')
if(length(input_filenames) == 0){
    stop(paste("Error: there are no csv files in INPUT_DIRECTORY:", INPUT_DIRECTORY))
}
for(i in 1:length(input_filenames)){
    if(is.na(input_matches[i,1])){
        print("The following file will not be treated as input, as it does not match attendance input file syntax:", quote = FALSE)
        print(input_filenames[[i]], quote = FALSE)
    }
}

## Populate inputs dataframe with input_matches
file_name <- c()
course_id <- c()
md_date <- c()
day_of_week <- c()
std_date <- c()
col_name <- c()
for(i in 1:nrow(input_matches)){
    if(!is.na(input_matches[i,1])){
        file_name <- append(file_name, input_matches[i,1])
        course_id <- append(course_id, input_matches[i,2])
        md_date <- append(md_date, input_matches[i,3])
        std_date <- append(std_date, as.Date(paste0(YEAR, "-", input_matches[i,3])))
        day_of_week <- append(day_of_week, substring(weekdays(std_date[length(std_date)]), 1, 2))
        col_name <- append(col_name, make.names(paste0(day_of_week[length(day_of_week)],
                                                       "_",
                                                       md_date[length(md_date)])))
    }
}
inputs <- data.frame(file_name=file_name, course_id=course_id, md_date=md_date,
                     std_date=std_date, day_of_week=day_of_week, col_name=col_name)

## If output files don't exist, create them
duped = duplicated(inputs$course_id)
keepers <- rep(TRUE, nrow(inputs))
for(i in 1:nrow(inputs)){
    if(!duped[i]){
        output_exists <- FALSE
        for(j in 1:nrow(output_matches)){
            if(!is.na(output_matches[j,2]) && inputs$course_id[i] == output_matches[j,2]){
                output_exists <- TRUE
                ## Remove rows from inputs that are already in output file w/ same page_range, dl_date
                existing_days <- colnames(read.csv(paste0(OUTPUT_DIRECTORY, output_matches[j,1])))
                for(k in 1:nrow(inputs)){
                    if(inputs$course_id[k] == output_matches[j,2] &&
                       inputs$col_name[k] %in% existing_days){
                        keepers[k] <- FALSE
                    }
                }
            }
        }
        if(!output_exists){
            new_file_name <- paste0("attendance_", inputs$course_id[i], ".csv")
            print(paste("creating output file", new_file_name), quote = FALSE)
            #file.create(new_file_name)
            df <- read.csv(paste0(INPUT_DIRECTORY, inputs$file_name[i]))
            ## df$Duration.Minutes. <- strtoi(df$Duration.Minutes.) ##unnecesary?
            df <- aggregate(Duration.Minutes. ~ Name, data = df, FUN = sum)
            new_df <- data.frame(Name = df$Name)
            write.table(new_df, file = paste0(OUTPUT_DIRECTORY, new_file_name), row.names = FALSE)
        }
    }
}
inputs <- inputs[keepers,] # keep a row iff keepers is TRUE
## TODO: check that this is functional

if(nrow(inputs) > 0){
    for(i in 1:nrow(inputs)){
        idf <- read.csv(paste0(INPUT_DIRECTORY, inputs$file_name[i]))
        idf <- aggregate(Duration.Minutes. ~ Name, data = idf, FUN = sum)
        idf[inputs$col_name[i]] <- idf$Duration.Minutes.
        idf <- select(idf, Name, inputs$col_name[i])
        output_file_name <- paste0(OUTPUT_DIRECTORY, "attendance_", inputs$course_id[i], ".csv")
        odf <- read.csv(output_file_name)
        odf <- merge(odf, idf, by = "Name", all = TRUE, sort = TRUE)
        odf <- odf[ , sort_cols(colnames(odf))] ## sort columns in date order
        headings <- c("Name", make.headings(colnames(odf))[2:length(colnames(odf))])
        write.table(odf, file = output_file_name, sep = ",",
                    row.names = FALSE, col.names = headings)
    }
}
