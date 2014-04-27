__run_analysis.R__

This is the only script in this repository.  When it is run in a directory containing the appropriate data, it will merge the supplied test sets, extract only the "mean" and "std" measurements, replace the activity IDs with activity names, and create a file called "tidy_data.txt" that contains the average of each variable grouped by activity and subject.

__How to Run__
* Clone the repository (or simply download the single file `run_analysis.R`)
* Download the dataset supplied here (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Unzip the dataset into a valid directory
* `cd` to the directory created... it should be named `UCI HAR Dataset`
* run the script (`Rscript <file_path>/run_analysis.R` -- if there are library loading issues you may have better luck just opening the file in Rstudio and running from there, ensuring that you are in the above directory)
* Wait...
* When it is finished there should be a file called `tidy_data.txt` in the `UCI HAR Dataset` directory
