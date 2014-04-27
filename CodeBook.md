### Assumptions about the Data
* One main assumption is that the data look like the data in the supplied example data file (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* The other main assumption is that the script is run in the top level directory created when unzipping the file above
* What this means specifically:
  * There is one `train` and one `test` directory
  * The `train` directory contains the files:
    * `X_train.txt` - data measurements
    * `y_train.txt` - activity id's (matches the # of lines in `X_train.txt`
    * `subject_train.txt` - subject id's (matches the # of lines in `X_train.txt`
  * Similarly the `test` directory contains the files:
    * `X_test.txt`
    * `y_test.txt`
    * `subject_test.txt`
  * The top level directory contains certain files:
    * `features.txt` - the second column of this file contains the names of the measurements taken.  This corresponds to columns of the data.frame so the number of lines in this file should match the number of columns in the `X_<train/test>.txt` file.  A measurement is considered a "mean" if it has the text `-mean()` in it.  A measurment is considered a "std" if it has the text `-std()` in it.  These are the columns that will be extracted by the `run_analysis.R` script.
    * `activity_labels.txt` - this contains an ID and corresponding activity name for each of the possible activity id's (see `y_<train/test>.txt` above)
  * Any other file in this directory is ignored.

### Data Transformation
* All transformation is performed by the script itself. Here are the steps:
1. Read all datasets (X, y, subject) from both directories (test, train)
2. Get feature names and apply those to column names of X datasets
3. Give names to subject (Subject-ID) and y (Activity-ID) datasets
4. Extract only the `-mean()` and `-std()` measurements
5. Add the extra Subject-ID, Activity-ID, and Activity-Name columns to the main datasets
6. Add the training dataset and test dataset together
7. Get the mean of each measurement grouped by Activity and Subject
8. Write the resulting data.table to disk under the name `tidy_data.txt`
