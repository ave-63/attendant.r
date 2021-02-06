#!/usr/bin/env bash

## USER OPTIONS:

## Path to folder containing all your downloaded csv files. You must edit this!
## Note the format: No spaces, and make sure it ends with /
INPUT_DIRECTORY=/home/ben/Downloads/csv_stuff/

## Path to folder where you want your result csv files to go. You must edit this!
## Note the format: No spaces, and make sure it ends with /
OUTPUT_DIRECTORY=/home/ben/Dropbox/Courses/227/

## The current year
YEAR=2021

Rscript attendant.r $INPUT_DIRECTORY $OUTPUT_DIRECTORY $YEAR
read -p "All done! Press [Enter] to quit."
